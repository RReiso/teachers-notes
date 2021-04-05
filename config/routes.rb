Rails
  .application
  .routes
  .draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    root to: "home#index"
    get "/search", to: "home#search", as: :search_path
    get "/signup", to: "users#new", as: :sign_up
    get "/login", to: "sessions#new" #login_path
    post "/login", to: "sessions#create" #login_path
    delete "/logout", to: "sessions#destroy" #logout_path
    get "/activities", to: "activities#all_activities", as: :all_activities
    get "/activities/category", to: "activities#category", as: :category
    # get "/users/:user_id/activities", to: "activities#index", as: user_activities_path(current_user_method)
    # get "/users/:user_id/activities/new", to: "activities#new", as: new_user_activity_path(current_user_method)
    
    resources :users do
      resources :activities
    end
  end
