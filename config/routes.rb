Rails.application.routes.draw do
  get "play_events/index"
  get "play_events/show"
  get "play_events/new"
  get "play_events/create"
  get "play_events/edit"
  get "play_events/update"
  get "play_events/destroy"
  get "play_events/join"
  resources :sports
  devise_for :users
  get "home/index"
  root "home#index"

  authenticate :user do
    get "/play", to: "play_events#index"
    get "/moments", to: "posts#index"
    get "/track", to: "pages#track"
    get "/profile", to: "users#profile"
    get "/profile/edit", to: "users#edit", as: "edit_profile"
    patch "/profile", to: "users#update", as: :update_profile
    
    resources :posts, only: [:index, :new, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
    end

    resources :play_events do
      member do
        post 'join'
        delete 'leave'
      end
      
      # Nested join_requests routes
      resources :join_requests, only: [:create] do
        collection do
          delete :cancel, as: :cancel # This adds the cancel_join_request_path
        end
      end
    end

    resources :join_requests, only: [] do
      member do
        patch :accept
        patch :reject
      end
    end

    post "/posts/:id/like", to: "posts#like", as: :like_post
  end
end