class HomeController < ApplicationController
	skip_before_filter :authenticate
	cache_page :about_me
end
