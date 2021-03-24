Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      resources :customers, only: %i[ create show ]
      resources :enrollments, only: %i[ create ]
    end
  end
end
