Rails.application.routes.draw do
  controller :root do
    get :info, format: :json
    get "/calendar/:token.ics", action: :calendar

    get "*path", action: :index, constraints: -> (request) do
      %w[/api /rails].none? { |prefix| request.path.start_with?(prefix) }
    end
  end

  namespace :api, defaults: { format: :json } do
    scope :session, controller: :session do
      patch :geolocation
    end

    scope :proxy, controller: :proxy do
      get :google_maps_places_search
    end

    resource :user, controller: :user, only: [:create, :show, :update]

    resource :login_links, only: [:create] do
      post :redeem
    end

    resources :users, only: [:show]
    resources :events, shallow: true do
      get :invite_search

      resource :invite, controller: :invite, only: [:update]
      resources :invites, only: [:create, :update], shallow: true
      resources :posts, only: [:create, :update, :destroy], shallow: true do
        resources :comments, only: [:create, :update, :destroy], shallow: true
      end
    end
  end
end
