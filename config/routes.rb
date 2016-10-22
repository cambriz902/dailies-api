Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:show]

      resources :dailies, only: [:show, :create] do
        collection do 
          get 'category_dailies'
        end
      end

      resources :daily_categories, only: [:create]
    end
  end
end
