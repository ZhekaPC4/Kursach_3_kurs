Rails.application.routes.draw do


  get "/", to: 'articles#index', as: :main_page
  get "/articles/:id", to: "articles#show", as: :article_by_id

	get "login/", to: 'users#login', as: :user_login
  post "/user/auth", to: 'users#auth', as: :user_auth

  get "/user/new", to: 'users#new', as: :user_new
  post "/user/create", to: 'users#create', as: :user_create
  
  get "/user/:id", to: 'users#show', as: :user
  get "/user/all", to: 'users#all', as: :user_all

  get "/logout", to: 'users#log_out', as: :user_log_out

  get "article/new", to: 'articles#new', as: :article_new
  get "article/create", to: 'articles#create', as: :article_create
  get "article/:id/delete", to: 'articles#delete', as: :article_delete
  get "article/:id/edit", to: 'articles#edit', as: :article_edit
  get "article/:id/change", to: 'articles#change', as: :article_change


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
