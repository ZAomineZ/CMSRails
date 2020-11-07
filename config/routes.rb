Rails.application.routes.draw do

  root to:'pages#home'

  resources :posts, controller: 'posts'
  resources :category, controller: 'category'

  post '/posts/pagination/:page' => 'api/pagination_posts#set_pagination'

end
