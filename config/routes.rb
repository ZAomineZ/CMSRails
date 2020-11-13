Rails.application.routes.draw do

  root to:'pages#home'

  # Routes Admin
  get '/admin', to: 'pages#admin', as: 'admin_page'

  namespace :admin do
    resources :posts, controller: 'posts', to: '/admin/posts'
    resources :category, controller: 'category', to: '/admin/categories'
  end

  # Entity routes post pagination
  post '/posts/pagination/:page' => 'api/pagination#set_pagination_posts'
  post '/categories/pagination/:page' => 'api/pagination#set_pagination_categories'

  post '/search/:q' => 'api/search#results'

  # Routes Auth
  get '/login', to: 'users#login', as: 'login'
  post '/login', to: 'users#signin', as: 'signin'
  post '/logout', to: 'users#logout', as: 'logout'

  # Routes Account
  get '/account', to: 'users#account', as: 'account'
  put '/account/:user_id', to: 'users#update_account', as: 'update_account'

end
