#frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
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
end
