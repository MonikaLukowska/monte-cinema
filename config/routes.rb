#frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :movies, except: [:show]
  
  resources :seances do
    resources :reservations, only: %i[new create index]
  end
  resources :reservations, only: %i[index] do
    member do
      patch 'cancel', to: 'reservations#cancel'
      patch 'confirm', to: 'reservations#confirm'
    end
  end
 
  root to: 'seances#index'
end
