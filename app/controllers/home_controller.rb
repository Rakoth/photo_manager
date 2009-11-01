class HomeController < ApplicationController
	skip_before_filter :authenticate
	caches_page  :about_me
end
