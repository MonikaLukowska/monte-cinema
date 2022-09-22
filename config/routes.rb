#frozen_string_literal: true

Rails.application.routes.draw do
 
 resources :movies, except: [:show]
 resources :seances do
  resources :reservations, only: %i[new create]
 end
 
 root to: 'seances#index'
end
