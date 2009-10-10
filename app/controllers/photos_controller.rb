class PhotosController < ApplicationController
	before_filter :find_photo, :except => [:index, :new, :create, :sort]

	def index
		@photos = Photo.all
	end

	def without_album
		@photos = Photo.without_album
		render :index
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
			render :new
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

	def sort
		params[:photos].each_with_index do |photo_id, index|
			Photo.update_all ['position = ?', index + 1], ['id = ?', photo_id]
		end
		render :nothing => true
	end

	protected

	def find_photo
		@photo = Photo.find params[:id]
	end
end
