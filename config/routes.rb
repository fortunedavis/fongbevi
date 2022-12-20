Rails.application.routes.draw do
  root "home#index"
 
  resources :votes
  resources :clips
  resources :admin


  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }


  
  #ApiV1
  namespace :api do
    devise_for :users,
      controllers: {
        sessions: 'api/users/sessions',
        registrations: 'api/users/registrations',
      }
  end

  #Admin
  namespace :admin  do

   # devise_for :users,
    #  controllers: {
    #    sessions: 'users/sessions',
    #    passwords: 'users/registrations',
    #  }
    
      resources :sentences
      resources :clips
      resources :registrations
      get "utilisateurs" =>"users#index"
  end
  

  devise_scope :user do
    get 'sign_out' => 'devise/sessions#destroy'
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
