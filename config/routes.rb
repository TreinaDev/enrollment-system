Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  resources :enrollments, only: %i[ new create ]

  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      resources :customers, only: %i[ create show ] do
        get 'status', on: :collection
      end
    end
  end
end
