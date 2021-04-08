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
    get "/activities/:id", to: "activities#update_heart_count"
    
    resources :users do
      resources :activities do
        resources :comments
      end
    end
  end
