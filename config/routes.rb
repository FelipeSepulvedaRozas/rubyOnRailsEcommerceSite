Rails.application.routes.draw do
  resources :orders do 
    resources:orderitems
  end
  resources :categories
  resources :items
  
  devise_for :users do 
    resources:orders
  end  
 
  root 'pages#index'
  
  get '/home',  to: 'pages#index'
  
  get '/category/:title', to: 'pages#category'
  
  get '/cart', to: 'cart#index'
  get '/cart/clear', to: 'cart#clear'
  get '/cart/:id', to: 'cart#add'
  get '/cart/remove/:id' => 'cart#remove'
  
  get '/checkout' => 'cart#orderCreate'
  
  get '/paymentAccepted' => 'pages#paymentAccepted'
  
  post '/search' => 'pages#search'
  
end
