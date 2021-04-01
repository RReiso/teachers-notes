Rails
  .application
  .routes
  .draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    root to: "home#index"
    get "/search", to: "home#search", as: :search_path
    get "/signup", to: "users#new", as: :sign_up
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new", as: :log_in
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "/activities/liked", to: "activities#liked", as: :liked
    get "/activities/my_activities",
    to: "activities#my_activities",
    as: :my_activities
    resources :activities
    resources :users
  end
