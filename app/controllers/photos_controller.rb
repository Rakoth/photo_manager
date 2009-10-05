class PhotosController < ApplicationController
	before_filter :find_photo, :except => [:index, :new, :create]

	def index
		@photos = Photo.all
	end

	def without_album
		@photos = Photo.without_album
		render :action => :index
	end

  def new
		@photo = Photo.new
  end

	def create
		@photo = Photo.new params[:photo]
		if @photo.save
			flash[:notice] = t 'photos.flash.created'
			redirect_to photo_path @photo
		else
			flash[:error] = t 'photos.flash.creating_failed'
			render :action => :new
		end
	end

	def destroy
		@photo.destroy
		respond_to do |format|
			format.html do
				flash[:notice] = t 'photos.flash.deleted'
				redirect_to root_path
			end
			format.js do
				render :nothing => true
			end
		end
	end

	def reset_rating
		@photo.reset_rating!
	end

	protected

	def find_photo
		@photo = Photo.find params[:id]
	end
end
