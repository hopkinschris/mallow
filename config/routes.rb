Mallowapp::Application.routes.draw do

  root :to => "home#show"

  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure' => 'sessions#failure'

  match '/request' => 'sessions#new', :as => :request
  match '/logout' => 'sessions#destroy', :as => :logout

  resources :users, :only => [ :show, :edit, :update ]

end
