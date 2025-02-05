class PagesController < ApplicationController

  before_action :only_signed_in, only: [:admin]
  before_action :admin_access, only: [:admin]

  layout nil, only: [:sitemap]
  layout 'application', only: [:admin]
  layout 'template', only: [:home]

  def home
    @categories_last_4 = Category.desc.limit(4)
    @categories_last_6 = Category.desc.offset(4).limit(6)
    @posts = Post.desc.limit(12)
  end

  def admin
    @posts_count = Post.count

    pagination = PaginationEntity.new(1, Post)
    @posts = pagination.get_data[:items]
    @pages = pagination.get_pages
    @current_page = pagination.get_data[:current_page]

    @message_success = flash[:success]
    @message_danger = flash[:danger]
    render 'admin/dashboard'
  end

  def sitemap
    @host = "#{request.protocol}#{request.host}"
    @posts = Post.all
    @last_post = Post.desc.limit(1)[0]
  end
end