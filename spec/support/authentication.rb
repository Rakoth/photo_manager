def authenticate
	session[:password], session[:salt] = AdminPasswordKeeper.authentication_data(AppConfig.password)
end