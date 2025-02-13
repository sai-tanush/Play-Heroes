Rails.application.routes.draw do
  get "pages/play"
  get "pages/moments"
  get "home/index"
  root "home#index"
  get "/play", to: "pages#play"
  get "/moments", to: "pages#moments"
  get "/profile", to: "users#profile"
end
