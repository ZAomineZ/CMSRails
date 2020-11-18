class Admin::CategoryController < ApplicationController

  before_action :set_category, only: [:edit, :update]
  before_action :set_category_with_slug, only: [:show]
  before_action :admin_access, only: [:new, :create, :edit, :update, :destroy]

  layout 'template', only: [:show]

  def index
    pagination = PaginationEntity.new(1, Category)
    @categories = pagination.get_data[:items]
    @pages = pagination.get_pages
    @current_page = pagination.get_data[:current_page]

    @message_success = flash[:success]
    @message_danger = flash[:danger]
  end

  def new
    @errors = flash[:errors]
    @message_error = flash[:danger]
    @message_success = flash[:success]
  end

  def create
    # Set credentials category entity
    @category = Category.new(params_category)
    @category.date_cat = Time.now
    @category.avat_cat = params[:image]

    # Check if the category title exist already !
    category_exist = Category.find_by_name(params[:name])
    if !category_exist.empty? && @category.id != params[:id]
      flash[:danger] = 'This title is already use in a another category.'
      return render action: 'new'
    end

    if @category.save
      # Update informations file
      set_image_credentials

      flash[:success] = "Category was successfully created."
      redirect_to admin_category_index_path
    else
      flash[:danger] = 'An error occurred when validating to your request.'
      flash[:errors] = @category.errors.messages
      redirect_to new_admin_category_path
    end
  end

  def edit
    @errors = flash[:errors]
    @message_error = flash[:danger]
    @message_success = flash[:success]
  end

  def update
    # Update credentials image
    if params[:image] != nil
      @category.avat_cat = params[:image]
    end
    if @category.update(params_category)
      # Edited version icon avatar
      if params[:image] != nil
        set_image_credentials
      end

      flash[:success] = "Category was successfully edited."
      redirect_to admin_category_index_path
    else
      flash[:danger] = 'An error occurred when validating to your request.'
      flash[:errors] = @category.errors.messages
      redirect_to edit_admin_category_path
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

      flash[:success] = "Category was successfully deleted."
    else
      flash[:danger] = 'An error occurred when delete your category.'
    end
    redirect_to admin_category_index_path
  end

  def show
    @posts = Post.find_by_category(@category)
    @categories = Category.all
  end

  private

  def params_category
    params.permit(:name, :slug, :resume)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def set_category_with_slug
    @category = Category.find_by_slug(params[:slug] ? params[:slug] : nil).first
  end

  def set_image_credentials
    image = params[:image]
    @category.icon_cat = image != nil && !image.instance_of?(String) ? 'icon_' + @category.avat_cat_identifier : 'image_50.png'
    @category.save
  end

end