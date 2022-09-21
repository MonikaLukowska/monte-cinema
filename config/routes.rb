Rails.application.routes.draw do
 #frozen_string_literal: true

 resources :movies, except: [:show]
 resources :seances

 root to: 'seances#index'
end
