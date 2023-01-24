Rails.application.routes.draw do
  scope :api, module: :api, defaults: { format: :json } do
    get :info, controller: :root
    get :health, controller: :root

    resources :users, only: [:show]
    resource :session, only: [:create] do
      post :start
    end

    resource :user, controller: :user, only: [:create, :show, :update]
  end

  get "*path", to: "static#index", constraints: -> (request) { !request.path.start_with?("/api") }
end
