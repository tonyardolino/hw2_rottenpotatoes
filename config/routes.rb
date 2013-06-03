Rottenpotatoes::Application.routes.draw do

  root :to => 'movies#index'
  resources :movies
#  get  'auth/:provider/callback' => 'sessions#create',:as => 'login'
  post 'logout' => 'sessions#destroy'
#  get  'auth/failure' => 'sessions#failure'
  get   '/login', :to => 'sessions#create', :as => :login
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'

end
