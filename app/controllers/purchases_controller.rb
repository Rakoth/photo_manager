class PurchasesController < ApplicationController
	before_filter :authenticate, :except => [:new, :create]
	before_filter :find_photo, :only => [:new, :create]
	
  def index
		@purchases = Purchase.all :order => 'created_at DESC'
		Purchase.unwatched.update_all ['view_at = ?', Time.now]
  end

  def new
		@purchase = Purchase.new :contact => Contact.new
  end

	def create
		@purchase = @photo.purchases.build params[:purchase]
		if @purchase.save
			flash[:notice] = t 'purchases.flash.created'
			redirect_to root_url
		else
			flash.now[:error] = t 'purchases.flash.creating_failed'
			render :new
		end
	end

	def destroy
		@purchase = Purchase.find params[:id]
		@purchase.destroy
	end

	def delete_all
		Purchase.delete_all
		flash[:notice] = t 'purchases.flash.deleted'
		redirect_to root_url
	end

	protected

	def find_photo
		@photo = Photo.find params[:photo_id]
	end
end
