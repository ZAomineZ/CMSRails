  class Api::PaginationController < ApplicationController

    def set_pagination_posts
      page = params[:page]
      pagination = PaginationEntity.new(page, Post)
      if pagination.is_possible
        data = pagination.get_data

        response = {success: true, data: data}
      else
        response = {success: false, message: 'This page don\'t exist for this entity.'}
      end
      render json: response
    end

    def set_pagination_categories
      page = params[:page]
      pagination = PaginationEntity.new(page, Category)
      if pagination.is_possible
        data = pagination.get_data

        response = {success: true, data: data}
      else
        response = {success: false, message: 'This page don\'t exist for this entity.'}
      end
      render json: response
    end

  end
