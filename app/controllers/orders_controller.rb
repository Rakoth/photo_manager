class OrdersController < ApplicationController
	before_filter :authenticate, :except => [:new, :create]

  def index
		@orders = Order.all :order => 'created_at DESC'
		Order.unwatched.update_all ['view_at = ?', Time.now]
  end

  def new
		@order = Order.new
  end

	def create
		@order = Order.new params[:order]
		if @order.save
			flash[:notice] = t 'orders.flash.created'
			redirect_to root_url
		else
			flash[:error] = t 'orders.flash.creating_failed'
			render :new
		end
	end

	def destroy
		@order = Order.find params[:id]
		@order.destroy
	end

	def delete_expired
		Order.delete_all ['start_at < ?', Time.now]
		flash[:notice] = t 'orders.flash.expired_deleted'
		redirect_to orders_url
	end
end
