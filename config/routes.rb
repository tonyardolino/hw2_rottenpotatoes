Rottenpotatoes::Application.routes.draw do

  root :to => 'movies#index'
  resources :movies do
    resources :reviews
  end
  post '/movies/search_tmdb'
  post '/movies/similar_movie'
  post '/movies/movies_with_filters'
  get 'logout' => 'sessions#destroy'
  get   '/login', :to => 'sessions#create', :as => :login
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'

end
