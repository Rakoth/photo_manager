class CommentsController < ApplicationController
	skip_before_filter :authenticate, :only => :create
	before_filter :find_comment, :only => [:destroy, :spam, :ham]

	has_rakismet :only => :create

	def index
		@comments = Comment.all
	end

	def new
		flash[:error] = t 'comments.flash.open_photo_before'
		redirect_to root_path
	end

	def create
		@photo = Photo.find(params[:photo_id])
		@comment = @photo.comments.build(params[:comment])
		@comment.request = request
		if @comment.save
			respond_to do |format|
				format.html do
					flash[:notice] = t 'comments.flash.created'
					redirect_to @photo
				end
				format.js
			end
		else
			respond_to do |format|
				format.html do
					flash[:error] = t 'comments.flash.creating_failed'
					render :action => :new
				end
				format.js
			end
		end
	end

	def destroy
		@comment.destroy
		flash[:notice] = t 'comments.flash.deleted'
		redirect_to @comment.photo
	end

	def spam
		@comment.mark_as_spam!
		respond_to do |format|
			format.html do
				flash[:notice] = t 'comments.flash.marked_as_spam'
				redirect_to comments_url
			end
			format.js
		end
	end

	def ham
		@comment.mark_as_ham!
		respond_to do |format|
			format.html do
				flash[:notice] = t 'comments.flash.marked_as_ham'
				redirect_to comments_url
			end
			format.js
		end
	end

	def delete_spam
		Comment.delete_spam!
		flash[:notice] = t 'comments.flash.spam_deleted'
		redirect_to comments_url
	end

	protected

	def find_comment
		@comment = Comment.find params[:id]
	end
end
