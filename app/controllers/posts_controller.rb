class PostsController < ApplicationController

  def index
  end

  def new

  end

  def create
    @post = Post.new(params_post)
    @post.date_post = Time.now
    if @post.save
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private

  def params_post
    params.permit(:name, :slug, :descr)
  end

end
