class CategoriesController < ApplicationController
  before_filter :find_category, :except => [:index, :new, :create]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def update
    if @category.update_attributes params[:category]
      flash[:notice] = t 'categories.flash.updated'
      redirect_to @category
    else
      flash[:error] = t 'categories.flash.updating_failed'
      render :edit
    end
  end

  def create
    @category = Category.new params[:category]
    if @category.save
      flash[:notice] = t 'categories.flash.created'
      redirect_to @category
    else
      render :new
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url
  end

  protected

  def find_category
    @category = Category.find params[:id]
  end
end
