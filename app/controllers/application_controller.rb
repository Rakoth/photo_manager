# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
	helper_method :admin?

	include ExceptionLoggable
	
	before_filter :authenticate, :except => [:index, :show]

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

	protected

	def admin?
		@admin ||= (AppConfig.password == session[:password])
	end

	def authenticate
		unless admin?
			flash[:error] = t 'application.flash.non_authorized'
			redirect_to login_path
		end
	end
end
