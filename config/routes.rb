Rails.application.routes.draw do

  root to:'pages#home'

  resources :posts, controller: 'posts'

  resources :category, controller: 'category'

end
