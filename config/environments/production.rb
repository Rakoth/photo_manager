# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true

# See everything in the log (default is :info)
# config.log_level = :debug

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Use a different cache store in production
# config.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host = "http://assets.example.com"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

require 'smtp-tls'

config.action_mailer.raise_delivery_errors = true

config.action_mailer.perform_deliveries = true
config.action_mailer.delivery_method = :smtp
config.action_mailer.default_charset = "utf-8"

#config.action_mailer.smtp_settings = {
#	:address => 'smtp-9.1gb.ru',
#	:port => 25,
#  :user_name => "u159267",
#  :password => "dcb0ecd0",
#	:authentication => :login
#}

config.action_mailer.smtp_settings = {
	:address => 'smtp.gmail.com',
	:port => 587,
  :user_name => "noreply.ellephoto@gmail.com",
  :password => "Qwerty@12",
  :authentication => :plain
}

# Enable threaded mode
# config.threadsafe!

# LoggedExceptions authentication settings
config.after_initialize do
	LoggedExceptionsController.class_eval do
		before_filter :authenticate

		protected

		def authenticate
			unless AppConfig.password == session[:password]
				flash[:error] = t 'application.flash.non_authorized'
				redirect_to login_path
			end
		end
	end
end
