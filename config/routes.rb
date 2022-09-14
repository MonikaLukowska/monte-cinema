Rails.application.routes.draw do
 #frozen_string_literal: true

 resources :movies, except: [:show]

 root to: 'movies#index'
end
