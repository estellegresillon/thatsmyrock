Rails.application.routes.draw do
  devise_for :users
  root to: 'albums#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :albums, only: [ :index, :show ] do
    resources :user_albums, only: [ :create, :update ]
  end

  resources :user_albums, only: [ :index, :show ]
  resources :artists, only: [ :show, :index ]

end
