Rails.application.routes.draw do


  get "/", to: 'articles#index', as: :main_page
  get "/articles/:id", to: "articles#show"

	get "login/", to: 'users#login', as: :user_login
  post "/user/auth", to: 'users#auth', as: :user_auth

  get "/user/new", to: 'users#new', as: :user_new
  post "/user/create", to: 'users#create', as: :user_create
  
  get "/user/:id", to: 'users#show', as: :user

   get "/logout", to: 'users#log_out', as: :user_log_out


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
