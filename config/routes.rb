Rails.application.routes.draw do
  devise_for :users

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
      post :like, on: :member # Simplified like route
    end

    resources :play_events do
      member do
        post 'join'
        delete 'leave'

        post 'create_chat' 
        get 'event_chat'
      end

      resources :join_requests, only: [:create] do
        collection do
          delete :cancel, as: :cancel
        end
      end
    end

    resources :join_requests, only: [] do
      member do
        patch :accept
        patch :reject
      end
    end
  end

  resources :sports
end