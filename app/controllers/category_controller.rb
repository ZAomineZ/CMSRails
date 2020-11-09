class CategoryController < ApplicationController

  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    pagination = PaginationEntity.new(1, Category)
    @categories = pagination.get_data[:items]
    @pages = pagination.get_pages
    @current_page = pagination.get_data[:current_page]
  end

  def new
  end

  def create
    @category = Category.new(params_category)
    @category.date_cat = Time.now
    if @category.save
      flash.now[:success] = "Category was successfully created."
      redirect_to @category
    else
      flash.now[:danger] = 'An error occurred when validating to your request.'
      flash.now[:errors] = @category.errors.messages
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @category.update(params_category)
      flash.now[:success] = "Category was successfully edited."
      redirect_to category_path
    else
      flash.now[:danger] = 'An error occurred when validating to your request.'
      flash.now[:errors] = @category.errors.messages
      render action: 'edit'
    end
  end

  def destroy
    id = params[:id]
    @category = Category.exists?(id)
    if @category
      @category.delete
      flash.now[:success] = "Category was successfully deleted."
    else
      flash.now[:danger] = 'An error occurred when delete your category.'
    end
    redirect_to category_path
  end

  private

  def params_category
    params.permit(:name, :slug, :resume)
  end

  def set_category
    @category = Category.find(params[:id])
  end

end