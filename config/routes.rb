Rails.application.routes.draw do
  resources :pages
  namespace :api do
     namespace :v1 do
       resources :books, only: [:index, :update, :show]
       resources :users, only: [:index, :show, :create]
       resources :pages, only: [:index, :show]
     end
   end
 end
