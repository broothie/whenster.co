Rails.application.routes.draw do
  get :healthz, controller: :root, format: :json
  get "*path", to: "root#index", constraints: -> (request) do
    %w[/api /rails].none? { |prefix| request.path.start_with?(prefix) }
  end

  namespace :api, defaults: { format: :json } do
    resource :user, controller: :user, only: [:create, :show, :update]

    resource :login_links, only: [:create] do
      post :redeem
    end

    resources :users, only: [:show]
    resources :events
  end
end
