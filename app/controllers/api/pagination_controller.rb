  class Api::PaginationController < ApplicationController

    def set_pagination_posts
      set_pagination(Post)
    end

    def set_pagination_categories
      set_pagination(Category)
    end

    private

    def set_pagination(entity)
      page = params[:page]
      pagination = PaginationEntity.new(page, entity)
      if pagination.is_possible
        data = pagination.get_data

        response = {success: true, data: data}
      else
        response = {success: false, message: 'This page don\'t exist for this entity.'}
      end
      render json: response
    end

  end
