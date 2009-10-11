class AlbumsController < ApplicationController
	before_filter :find_album, :except => [:index, :new, :create, :edit]

  def index
    @albums = Album.all
  end

  def new
    @album = Album.new
  end

	def create_photos
		params[:album][:photos_attributes].delete_if {|photo| photo[:image].blank?}
		if @album.update_attributes(params[:album])
			flash[:notice] = t 'albums.flash.photos_added'
			redirect_to @album
		else
			render :add_photos
		end
	end

  def create 
    @album = Album.new params[:album]
		if @album.save
			flash[:notice] = t 'albums.flash.created'
			redirect_to add_photos_album_url(@album)
		else
			render :new
		end
  end

	def edit
		@album = Album.find params[:id], :include => :photos
	end

  def update
		if @album.update_attributes(params[:album])
			flash[:notice] = t 'albums.flash.updated'
			redirect_to @album
		else
			render :edit
		end
  end

  def destroy
    @album.destroy
    redirect_to albums_url
  end

	def cover
		@album.cover = @album.photos.find params[:photo_id]
		@album.save
		render :nothing => true
	end

	protected

	def find_album
    @album = Album.find params[:id]
	end
end
