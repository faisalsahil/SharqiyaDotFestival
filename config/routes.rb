Rails.application.routes.draw do
  
  devise_for :users
  
  apipie
  # root to: 'apipie/apipies#index'
  root to: 'dashboard#index'
  
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'
  
  resources :roles
  resources :users, only:[:index, :edit, :destroy] do
    member do
      patch 'update_user'
    end
  end
  
  resources :companies

  namespace :api do
    namespace :v1 do
      resources :registrations, only: [] do
        collection do
          post :sign_up
          # post :sing_up_social_media
          post :forgot_password
        end
      end
      
      resources :user_sessions do
        collection do
          post :sign_in
        end
      end

      resources :companies, only: [:index, :show]
      
    end
  end

end