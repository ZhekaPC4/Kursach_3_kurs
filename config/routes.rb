Rails.application.routes.draw do


  get "/", to: 'teas#index', as: :main_page
  get "/tea/:id", to: "teas#show", as: :tea_by_id

	get "login/", to: 'users#login', as: :user_login
  post "/user/auth", to: 'users#auth', as: :user_auth
  
  get "/user/new", to: 'users#new', as: :user_new
  post "/user/create", to: 'users#create', as: :user_create
  
  get "/user/index", to: 'users#index', as: :user_index
  get "/user/id/:id", to: 'users#show', as: :user
  get "/logout", to: 'users#log_out', as: :user_log_out
  
  get "/user/delete/:id", to: 'users#delete', as: :user_delete
  
  get "/user/edit/:id", to: 'users#edit', as: :user_edit
  post "/user/update/:id", to: 'users#update', as: :user_update
  
  get "/teas/new", to: 'teas#new', as: :tea_new
  post "/teas/create", to: 'teas#create', as: :tea_create
  
  get "/tea/:id/edit", to: 'teas#edit', as: :tea_edit
  post "/tea/:id/update", to: 'teas#update', as: :tea_update
  get "/tea/:id/delete", to: 'teas#delete', as: :tea_delete
  
  get "/teas/cms", to: 'teas#cms', as: :tea_cms
  
  get "/tea/:id/addtocart", to: 'teas#addtocart', as: :tea_addtocart
  get "/orders/", to: 'orders#index', as: :order_index
  get "/bucket/", to: 'orders#bucket', as: :order_bucket
  get "/bucket/createOrder", to: 'orders#create', as: :order_create
  get "/order/:id", to: 'orders#status', as: :order_status
  post "/order/:id/new_status", to: 'orders#new_status', as: :order_new_status



  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
