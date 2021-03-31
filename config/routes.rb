Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  resources :activities
  get "/login", to: "home#login"
  get "/signup", to: "home#signup"
  # get "/login", controller: "home", action: "login"
end
