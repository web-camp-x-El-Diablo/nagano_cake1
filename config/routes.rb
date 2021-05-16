Rails.application.routes.draw do

  devise_scope :admin do
    get '/admin/sign_in' => "admin/sessions#new", as: :new_admin_session
    post '/admin/sign_in' => "admin/sessions#create", as: :admin_session
    delete '/admin/sign_out' => "admin/sessions#destroy",as: :destroy_admin_session
  end


  devise_for :customers
  
  get '/orders/thanks' => "orders#thanks"
  post '/orders/confirm' => "orders#confirm"
  delete '/cart_products/destroy_all' => "cart_products#destroy_all"
  patch '/customers/withdraw' => "customers#withdraw"
  get '/customers/unsubscribe' => "customers#unsubscribe"

  resource :customers, only: [:show, :edit, :update]

  root to: "homes#top"
  get "homes/about" => "homes#about"

  resources :products, only: [:index, :show]

  resources :cart_products, only: [:index, :update, :destroy, :create]

  resources :orders, only: [:index, :show, :new, :create]

  resources :deliveries, only: [:index, :edit, :update, :create, :destroy]


  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]

    resources :customers, only: [:index, :show, :edit, :update]

    resources :products, only: [:index, :show, :create, :update, :edit, :new]

    resources :orders, only: [:show, :update]

    resources :order_details, only: [:update]
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
