class Admin::PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update]

  def index
    pagination = PaginationEntity.new(1, Post)
    @posts = pagination.get_data[:items]
    @pages = pagination.get_pages
    @current_page = pagination.get_data[:current_page]
  end

  def new

  end

  def create
    categories = params[:categories]
    if categories.empty?
      response = {
          success: false,
          message: 'One category must be selected.'
      }
      return render json: response
    end

    if Category.dontExist(categories)
      response = {
          success: false,
          message: 'One of the selected categories don\'t exist.'
      }
      return render json: response
    end

    # Set Credentials Post
    @post = Post.new(params_post)
    @post.date_post = Time.now
    @post.category_id = categories
    @post.img_original = params[:image]

    if @post.save
      # Update informations file
      set_image_credentials

      response = {
          success: true,
          message: 'Post was successfully created.'
      }
    else
      response = {
          success: false,
          message: 'An error occurred when validating to your request.',
          errorFields: @post.errors.messages
      }
    end
    render json: response
  end

  def edit
  end

  def update
    categories = params[:categories]
    if categories.empty?
      response = {
          success: false,
          message: 'One category must be selected.'
      }
      return render json: response
    end

    if Category.dontExist(categories)
      response = {
          success: false,
          message: 'One of the selected categories don\'t exist.'
      }
      return render json: response
    end

    # Update credentials categories and images
    @post.category_id = categories
    @post.img_original = params[:image]
    if @post.update(params_post)
      # Update informations file
      set_image_credentials

      response = {
          success: true,
          message: 'Post was successfully edited.'
      }
    else
      response = {
          success: false,
          message: 'An error occurred when validating to your request.',
          errorFields: @post.errors.messages
      }
    end
    render json: response
  end

  def destroy
    id = params[:id]
    @exist = Post.exists?(id)

    if @exist
      @post = Post.find(id)
      @post.delete
      flash.now[:success] = "Post was successfully deleted."
    else
      flash.now[:danger] = "An error occurred when delete your post."
    end

    redirect_to admin_posts_path
  end

  private

  def params_post
    params.permit(:name, :slug, :descr)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_image_credentials
    image = params[:image]

    @post.img_medium = image != nil && !image.instance_of?(String) ? 'medium_' + @post.img_original_identifier : 'image_500.png'
    @post.img_thumb = image != nil && !image.instance_of?(String) ? 'thumb_' + @post.img_original_identifier : 'image_150.png'
    @post.img_mini = image != nil && !image.instance_of?(String) ? 'mini_' + @post.img_original_identifier : 'image_50.png'
    @post.save
  end

end
