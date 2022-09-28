#frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
 
  resources :movies, except: [:show]
  resources :seances do
    resources :reservations, only: %i[new create]
  end
 
  root to: 'seances#index'
end
