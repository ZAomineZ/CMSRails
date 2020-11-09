class Api::SearchController < ApplicationController

  def results
    q = params[:q]
    if q.empty?
      response = {success: false, message: 'The field search must be required.'}
      return render json: response
    end
    posts = Post.search(q).all
    categories = Category.search(q).all
    response = {success: true, data: {categories: categories, posts: posts}}
    render json: response
  end

end