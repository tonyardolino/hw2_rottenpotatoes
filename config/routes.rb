Rottenpotatoes::Application.routes.draw do

  root :to => 'movies#index'
  resources :movies
  get  'auth/:provider/callback' => 'sessions#create',:as => 'login'
  post 'logout' => 'sessions#destroy'
  get  'auth/failure' => 'sessions#failure'

end
