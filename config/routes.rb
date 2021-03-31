Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  get "/login", to: "home#login"
  get "/signup", to: "home#signup"
  get "/activities/liked", to: "activities#liked", as: :liked
  get "/activities/my_activities", to: "activities#my_activities", as: :my_activities
  resources :activities
  # get "/login", controller: "home", action: "login"
end
