Rails.application.routes.draw do
  devise_for :users
  get "home/index"
  root "home#index"
  get "/play", to: "pages#play"
  get "/moments", to: "pages#moments"
  get "/profile", to: "users#profile"

    # Authentication routes
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  
    get "/signup", to: "registrations#new"
    post "/signup", to: "registrations#create"
end
