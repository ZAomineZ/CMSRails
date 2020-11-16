class Admin::PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update]

  def index
    pagination = PaginationEntity.new(1, Post)
    @posts = pagination.get_data[:items]
    @pages = pagination.get_pages
    @current_page = pagination.get_data[:current_page]
  end

  def new
    @data_categories = Category.all.map { |category| category.name }
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

    # Check if the post exist already !
    post_exist = Post.find_by_name(params[:name])
    unless post_exist.empty?
      response = {
          success: false,
          message: 'This title is already use in a another post.'
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
    @categories = @post.category_id
    @categories = @categories.split(',')
    @data_categories = Category.all.map { |category| category.name }
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

    # Check if the post exist already !
    post_exist = Post.find_by_name(params[:name])
    if !post_exist.empty? && @post.id != params[:id].to_i
      response = {
          success: false,
          message: 'This title is already use in a another post.'
      }
      return render json: response
    end

    # Update credentials categories and images
    @post.category_id = categories
    if params[:image] != nil && params[:image] != 'null'
      @post.img_original = params[:image]
    end
    if @post.update(params_post)
      # Update informations file
      if params[:image] != nil && params[:image] != 'null'
        set_image_credentials
      end

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
      # Destroy entity post and image file
      Post.unlink_image(@post)
      @post.destroy

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

    @post.img_medium = image != nil && !image.instance_of?(String) ? 'medium_' + @post.img_original_identifier : 'medium_image.png'
    @post.img_thumb = image != nil && !image.instance_of?(String) ? 'thumb_' + @post.img_original_identifier : 'thumb_image.png'
    @post.img_mini = image != nil && !image.instance_of?(String) ? 'mini_' + @post.img_original_identifier : 'mini_image.png'
    @post.save
  end

end
