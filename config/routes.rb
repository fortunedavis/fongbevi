Rails.application.routes.draw do
  resources :votes
  resources :clips
  
  namespace :admin do
    resources :sentences
  end

  resources :admin

  root "home#index"

  get 'omniauth_test', to: 'home#display_omniauth'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
  get 'sign_out' => 'devise/sessions#destroy'
  end
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
