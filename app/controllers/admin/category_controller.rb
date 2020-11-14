class Admin::CategoryController < ApplicationController

  before_action :set_category, only: [:show, :edit, :update]

  def index
    pagination = PaginationEntity.new(1, Category)
    @categories = pagination.get_data[:items]
    @pages = pagination.get_pages
    @current_page = pagination.get_data[:current_page]
  end

  def new
  end

  def create
    # Set credentials category entity
    @category = Category.new(params_category)
    @category.date_cat = Time.now
    @category.avat_cat = params[:image]

    if @category.save
      # Update informations file
      set_image_credentials

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
    # Update credentials image
    @category.avat_cat = params[:image]
    if @category.update(params_category)
      # Edited version icon avatar
      set_image_credentials

      flash.now[:success] = "Category was successfully edited."
      redirect_to admin_categories_path
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
      # Destroy entity post and image file
      category = Category.find(id)
      category.destroy
      Category.unlink_image(category)

      flash.now[:success] = "Category was successfully deleted."
    else
      flash.now[:danger] = 'An error occurred when delete your category.'
    end
    redirect_to admin_categories_path
  end

  private

  def params_category
    params.permit(:name, :slug, :resume)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def set_image_credentials
    image = params[:image]
    @category.icon_cat = image != nil && !image.instance_of?(String) ? 'icon_' + @category.avat_cat_identifier : 'image_50.png'
    @category.save
  end

end