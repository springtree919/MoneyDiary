Rails.application.routes.draw do

  root 'sessions#new'
  get '/index', to: "users#index"
  resources :users, only: [:new, :create]
  get "/search", to: "static_pages#search"
  get "/result", to: "static_pages#result"
  get '/incomedetail', to: 'static_pages#incomedetail'
  get '/outgodetail', to: 'static_pages#outgodetail'
  resources :incomes, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :outgos, only: [:new, :create, :edit, :update, :destroy]
  get "/totalincome", to: "incomes#home"
  get "/totaloutgo", to: "outgos#home"
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get "total", to: "static_pages#total"
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
