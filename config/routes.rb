require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:create, :update, :destroy]
      resources :sessions, only: [:create, :destroy]
      resources :daily_categories, only: [:show, :index, :create, :update, :destroy]
      resources :dailies, only: [:index, :show, :create, :destroy]

      resources :dailies do
        member do
          put :complete
        end
      end

      get 'users/authenticated_user', to: 'users#authenticated_user'
    end
  end
end
