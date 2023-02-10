Rails.application.routes.draw do
  resources :notes do
    collection do
      patch 'reorder'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :images, only: :update
  end

  resources :folders

  # Defines the root path route ("/")
  root 'images#index'
end
