Rails.application.routes.draw do
  root "home#index"

  resources :plans, only: %i[ new create show edit update destroy ] do
    member do
      post 'buy'
      patch 'inactivate'
    end
  end

  devise_for :users

  resources :class_categories

  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      resources :customers, :only => %i[ create show ]
      resources :plans, :only => %i[ index show ]
      
      resources :enrollments, :only => %i[ show ] do
      end

    end
  end
end
