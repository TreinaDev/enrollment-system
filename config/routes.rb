Rails.application.routes.draw do
  root "home#index"

  devise_for :users

  resources :class_categories
  
  namespace 'api', defaults: { format: :json } do
    namespace 'v1' do
      resources :customers, :only => %i[ create show ]
    end
  end
end
