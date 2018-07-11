Rails.application.routes.draw do
  namespace :api do
     namespace :v1 do
       resources :books, only: [:index, :update, :show]
       resources :users, only: [:index, :show, :create]
     end
   end
 end
