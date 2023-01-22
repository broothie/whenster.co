Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users, only: [:create, :show]
    resources :sessions, only: [:create]

    resource :user, controller: :user, only: [:show]
  end
end
