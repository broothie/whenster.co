Rails.application.routes.draw do
  scope :api, module: :api, defaults: { format: :json } do
    get :info, controller: :root
    get :health, controller: :root

    resources :users, only: [:show]
    resource :session, only: [:create]
    resource :user, controller: :user, only: [:create, :show]
  end

  get "*path", to: "static#index"
end
