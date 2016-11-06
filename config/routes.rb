require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:show, :create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
      resources :daily_categories, only: [:show, :index, :create, :update, :destroy]
      resources :dailies, only: [:index, :show, :create, :destroy]
    end
  end
end
