class Admin::PostsController < ApplicationController

  before_action :set_post, only: [:edit, :update]
  before_action :set_post_with_slug, only: [:show]
  before_action :admin_access, only: [:new, :create, :edit, :update, :destroy]

  layout 'template', only: [:show]
  layout 'application', only: [:new, :edit]

  def initialize
    super
    @response_body = ResponseBody.new
  end

  def index
    pagination = PaginationEntity.new(1, Post)
    @posts = pagination.get_data[:items]
    @pages = pagination.get_pages
    @current_page = pagination.get_data[:current_page]

    @message_success = flash[:success]
    @message_danger = flash[:danger]
  end

  def new
  end

  def create
    # Check if the post exist already !
    post_exist = Post.find_by_name(params[:name])
    unless post_exist.empty?
      response = @response_body.response_json(false, 'This title is already use in a another post.')
      return render json: response
    end

    # Set Credentials Post
    @post = Post.new(params_post)
    @post.date_post = Time.now
    # Upload Image File
    @post.img_original = params[:image]
    @post.file_swf = params[:file_swf]
    if @post.save
      # Update informations file
      set_image_credentials

      flash[:success] = 'Post was successfully created.'
      response = @response_body.response_json(true, 'Post was successfully created.')
    else
      response = @response_body.response_json(false, 'An error occurred when validating to your request.', @post.errors.messages)
    end
    render json: response
  end

  def edit
  end

  def update
    # Check if the post exist already !
    post_exist = Post.find_by_name(params[:name])
    if !post_exist.empty? && @post.id != params[:id].to_i
      response = @response_body.response_json(false, 'This title is already use in a another post.')
      return render json: response
    end

    # Update credentials category and images
    if params[:image] != nil && params[:image] != 'null'
      @post.img_original = params[:image]
    end
    if params[:swf] != nil && params[:swf] != 'null'
      @post.file_swf = params[:file_swf]
    end
    update_action = params[:image] != nil || params[:image] != 'null' ? @post.update(params_post) : update_request_without_image
    if update_action
      # Update informations file
      if params[:image] != nil && params[:image] != 'null'
        set_image_credentials
      end

      flash[:success] = 'Post was successfully edited.'
      response = @response_body.response_json(true, 'Post was successfully edited.')
    else
      response = @response_body.response_json(false, 'An error occurred when validating to your request.', @post.errors.messages)
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

      flash[:success] = "Post was successfully deleted."
    else
      flash[:danger] = "An error occurred when delete your post."
    end

    redirect_to admin_posts_path
  end

  def show
    if @post == nil
      return redirect_to root_path
    end
    @posts = Post.all
  end

  private

  def params_post
    params.permit(:name, :slug, :descr)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_post_with_slug
    @post = Post.find_by_slug(params[:slug] ? params[:slug] : nil)
  end

  def set_image_credentials
    image = params[:image]

    @post.img_medium = image != nil && !image.instance_of?(String) ? 'medium_' + @post.img_original_identifier : 'medium_image.png'
    @post.img_thumb = image != nil && !image.instance_of?(String) ? 'thumb_' + @post.img_original_identifier : 'thumb_image.png'
    @post.img_mini = image != nil && !image.instance_of?(String) ? 'mini_' + @post.img_original_identifier : 'mini_image.png'
    @post.save
  end

  def update_request_without_image
    attributes = {name: params[:name], slug: params[:slug], descr: params[:descr]}
    @post.update_attributes(attributes)
  end

end
