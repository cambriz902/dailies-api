require 'api_constraints'

Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      devise_for :users
      resources :users, only: [:show, :create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
      
      resources :dailies, only: [:show, :create] do
        collection do 
          get 'category_dailies'
        end
      end

      resources :daily_categories, only: [:create]
    end
  end
end
