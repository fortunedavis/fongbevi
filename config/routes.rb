Rails.application.routes.draw do
  root "home#index"
 
  resources :votes
  resources :clips
    #resources :admin
  get "admin" =>"admin#index"

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
      resources :clips  
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
    get "audiosvalidates" =>"clips#clipsvalidated"
    get "audiosrejetes" =>"clips#clipsrejected"
    get "audios_sans_vote" =>"clips#clipswithoutvotes"
  end
  

  devise_scope :user do
    get 'sign_out' => 'devise/sessions#destroy'
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
