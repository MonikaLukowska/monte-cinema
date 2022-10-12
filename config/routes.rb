#frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount Sidekiq::Web => '/sidekiq'
  
  devise_for :users
  resources :movies, except: [:show]
  
  resources :seances do
    post 'reservations/create_at_desk', to: 'reservations#create_at_desk', as: :desk_reservation
    resources :reservations, only: %i[new create] 
  end
  resources :reservations, only: %i[index] do
    member do
      patch 'cancel', to: 'reservations#cancel'
      patch 'confirm', to: 'reservations#confirm'
    end
  end
 
  root to: 'seances#index'

  namespace 'api' do
    namespace 'v1' do
      resources :movies, only: [:index] do
        collection do
          get 'find_by_date', as: 'screening_on'
        end
      end
      resources :seances, only: [:show]
    end
  end
end
