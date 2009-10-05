class RatingsController < ApplicationController
	skip_before_filter :authenticate, :only => :create

  def index
		@ratings = Rating.all
  end

	def create
		@photo = Photo.find params[:photo_id]
		@rating = @photo.ratings.build(params[:rating])
		@rating.request = request
		if @rating.save
			respond_to do |format|
				format.html do
					flash[:notice] = t 'ratings.flash.created'
					redirect_to @photo
				end
				format.js
			end
		else
			respond_to do |format|
				format.html do
					flash[:error] = t 'ratings.flash.creating_failed'
					redirect_to @photo
				end
				format.js do
					render :nothing => true
				end
			end
		end
	end
end
