module Api
  class PaginationPostsController < ApplicationController

    def set_pagination
      test = {success: true, data: 'test'}
      render json: test
    end

  end
end