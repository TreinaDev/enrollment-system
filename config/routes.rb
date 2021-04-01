Rails.application.routes.draw do
  devise_for :users
  
  root "home#index"
  
  resources :plans, only: %i[ new create show edit update destroy ] do
    member do
      post 'buy'
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
      resources :customers, :only => %i[ create show ]
    end
  end
end
