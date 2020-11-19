Rails.application.routes.draw do

  root to:'pages#home'

  # Routes Admin
  get '/admin', to: 'pages#admin', as: 'admin_page'

  scope "admin", as: "admin" do
    resources :posts, controller: 'admin/post', only: [:index, :new, :create, :edit, :update, :destroy]
    resources :category, controller: 'admin/category', only: [:index, :new, :create, :edit, :update, :destroy]
  end

  # Entity routes post pagination
  post '/admin/post/pagination/:page' => 'api/pagination#set_pagination_posts'
  post '/admin/category/pagination/:page' => 'api/pagination#set_pagination_categories'

  post '/search/:q' => 'api/search#results'

  # Routes Auth
  get '/login', to: 'users#login', as: 'login'
  post '/login', to: 'users#signin', as: 'signin'
  post '/logout', to: 'users#logout', as: 'logout'

  # Routes Account
  get '/admin/account', to: 'users#account', as: 'account'
  put '/admin/account/:user_id', to: 'users#update_account', as: 'update_account'

  # Routes coloriages
  get '/coloriage/:slug', to: 'admin/category#show'
  get '/:slug', to: 'admin/posts#show'

end
