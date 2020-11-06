class PostsController < ApplicationController

  def index
    @posts = Post.paginate(:page => params[:page])
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

    @post = Post.new(params_post)
    @post.date_post = Time.now
    @post.category_id = categories
    if @post.save
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
    @post = Post.find(params[:id])
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

    @post = Post.find(params[:id])
    @post.category_id = categories
    if @post.update(params_post)
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
    @post = Post.exists?(id)

    if @post
      @post = Post.find(id)
      @post.delete
      flash.now[:success] = "Post was successfully deleted."
    else
      flash.now[:danger] = "An error occurred when delete your post."
    end

    redirect_to posts_path
  end

  private

  def params_post
    params.permit(:name, :slug, :descr)
  end

end
