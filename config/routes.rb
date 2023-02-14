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

  resources :folders do
    resources :bookmarks
  end

  resources :rooms, only: %i[index show]

  resources :messages, only: %i[create show update] do
    resources :likes, only: %i[create destroy]
  end

  # Defines the root path route ("/")
  root 'images#index'
end
