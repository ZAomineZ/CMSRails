class CategoryController < ApplicationController

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
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
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
      @category = Category.find(id)
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

end