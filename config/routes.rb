Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    get :info, controller: :root
    get :health, controller: :root

    resources :users, only: [:show]
    resource :user, controller: :user, only: [:create, :show, :update]

    resource :login_links, only: [:create] do
      post :redeem
    end

    resources :events
  end

  get "*path", to: "static#index", constraints: -> (request) { !request.path.start_with?("/api") }
end
