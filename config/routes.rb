Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :plans, only: %i[ new create show edit update destroy ]

  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      resources :customers, :only => %i[ create show ]
    end
  end
end
