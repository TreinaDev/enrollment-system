Rails.application.routes.draw do
  root "home#index"
  resources :enrollments, only: %i[ new create ]

  devise_for :users

  resources :class_categories
  
  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      resources :customers, only: %i[ create show ] do
        get 'status', on: :collection
      end
    end
  end
end
