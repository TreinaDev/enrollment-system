Rails.application.routes.draw do
  devise_for :users
  
  root "home#index"
  
  resources :plans, only: %i[ new create show edit update destroy ] do
    member do
      patch 'inactivate'
    end
  end

  resources :enrollments, only: %i[ index create new show ] do
    member do
      post 'inactivate'
    end
  end

  resources :class_categories

  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      resources :class_categories, only: %i[ index show ]
      resources :customers, only: %i[ create show ] do
        get 'status', on: :collection
      end
      resources :plans, only: %i[ index ]
      resources :enrollments, only: %i[ show ]
    end
  end
end
