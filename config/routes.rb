Rails.application.routes.draw do
  resources :genres
  
  root "movies#index"
  
  get "movies/filter/:filter" => "movies#index", as: :filtered_movies

  resources :movies do 
    resources :reviews
    resources :favorites


  end

  resource :session, only: [:new, :create, :destroy]

  
  resources :users
    get "signup" => "users#new"

  

end
