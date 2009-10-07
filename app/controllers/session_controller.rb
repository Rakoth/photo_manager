class SessionController < ApplicationController
	skip_before_filter :authenticate
	
  def create
		session[:password] = params[:password]
		if admin?
			flash[:notice] = t 'session.flash.successful_login'
			redirect_to root_url
		else
			reset_session
			flash[:error] = t 'session.flash.login_failed'
			render :new
		end
  end

	def destroy
		reset_session
		flash[:notice] = t 'session.flash.successful_logout'
		redirect_to root_url
	end
end

