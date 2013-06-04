Rottenpotatoes::Application.routes.draw do

  root :to => 'movies#index'
  resources :movies
  get 'logout' => 'sessions#destroy'
  get   '/login', :to => 'sessions#create', :as => :login
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'

end
