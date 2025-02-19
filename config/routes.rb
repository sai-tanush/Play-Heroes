Rails.application.routes.draw do
  resources :sports
  devise_for :users
  get "home/index"
  root "home#index"

  authenticate :user do
    get "/play", to: "pages#play"
    get "/moments", to: "posts#index"
    get "/track", to: "pages#track"
    get "/profile", to: "users#profile"
    get "/profile/edit", to: "users#edit", as: "edit_profile"
    patch "/profile", to: "users#update", as: :update_profile
    resources :posts, only: [:new, :create, :show, :edit, :update, :destroy]
  end

end
