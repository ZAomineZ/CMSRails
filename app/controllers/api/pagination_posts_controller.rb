  class Api::PaginationPostsController < ApplicationController

    def set_pagination
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

  end
