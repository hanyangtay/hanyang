Rails.application.routes.draw do

  root 'sessions#new'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get 'password_resets/new'
  get 'password_resets/edit'
  get '/explore', to: 'status_posts#explore'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/guest_login', to: 'sessions#new_guest'
  get '/guest_login2', to: 'sessions#new_guest_2'
  get '/guest_login3', to: 'sessions#new_guest_3'
  
  resources :users do
    member do
      get :following, :followers, :likes
    end
  end
  
  resources :account_activations, only: [:edit]
  
  resources :password_resets, only: [:new, :create, :edit, :update]
  
  resources :status_posts, only: [:create, :destroy, :index] do
    member do
      post :repost
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  
  resources :likes, only: [:create, :destroy]
  

end