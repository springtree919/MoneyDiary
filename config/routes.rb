Rails.application.routes.draw do

  get 'sessions/new'

  get '/index', to: "users#index"

  root 'sessions#new'
  
  resources :users, only: [:new, :create]

  get '/incomedetail', to: 'static_pages#incomedetail'

  get '/outgodetail', to: 'static_pages#outgodetail'
  
  resources :incomes, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :outgos, only: [:new, :create, :edit, :update, :destroy]
  get "/totalincome", to: "incomes#home"
  get "/totaloutgo", to: "outgos#home"
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
