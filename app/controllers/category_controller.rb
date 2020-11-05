class CategoryController < ApplicationController

  def index
    @categories = Category.paginate(:page => params[:page])
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
      puts @category.errors.messages.inspect
      flash.now[:danger] = 'An error occurred when validating to your request.'
      flash.now[:errors] = @category.errors.messages
      render action: 'new'
    end
  end

  def edit

  end

  def update

  end

  private

  def params_category
    params.permit(:name, :slug, :resume)
  end

end