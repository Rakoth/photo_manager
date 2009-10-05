def authenticate
	session[:password] = AppConfig.password
end