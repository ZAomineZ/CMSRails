class PagesController < ApplicationController

  before_action :only_signed_in, only: [:admin]
  before_action :admin_access, only: [:admin]

  def home
  end

  def admin
    @posts_count = Post.count
    @categories_count = Category.count

    pagination = PaginationEntity.new(1, Post)
    @posts = pagination.get_data[:items]
    @pages = pagination.get_pages
    @current_page = pagination.get_data[:current_page]

    render 'admin/dashboard'
  end

end