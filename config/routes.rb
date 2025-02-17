Rails.application.routes.draw do
  devise_for :users
  get "home/index"
  root "home#index"

  authenticate :user do
    get "/play", to: "pages#play"
    get "/moments", to: "pages#moments"
    get "/profile", to: "users#profile"
  end

end
