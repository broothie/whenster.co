Rails.application.routes.draw do
  scope :api, module: :api, defaults: { format: :json } do
    get :info, controller: :root
    get :health, controller: :root

    resources :users, only: [:create, :show]
    resources :sessions, only: [:create]

    resource :user, controller: :user, only: [:show]
  end
end
