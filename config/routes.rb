Rails.application.routes.draw do

  root to:'pages#home'

  resources :posts, controller: 'posts'
  resources :category, controller: 'category'

  # Entity routes post pagination
  post '/posts/pagination/:page' => 'api/pagination#set_pagination_posts'
  post '/categories/pagination/:page' => 'api/pagination#set_pagination_categories'

end
