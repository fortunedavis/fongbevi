Rails.application.routes.draw do
  root "home#index"
 
  resources :votes, except: [:index,:edit, :update, :show, :destroy]
  resources :clips, except: [:index,:edit, :update, :show, :destroy]
    #resources :admin
  get "admin" =>"admin#index"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',

  }


  
  #ApiV1
  namespace :api do
    devise_for :users,
      controllers: {
        sessions: 'api/users/sessions',
        registrations: 'api/users/registrations',
      }
      resources :clips ,except:[:edit, :show]
      resources :votes ,except:[:edit, :show]
      resources :home ,only:[:index]
  end

  #Admin
  namespace :admin  do

    devise_for :users,
     controllers: {
        registrations: 'admin/users/registrations',
      }
    
    resources :sentences
    resources :clips 
    
    get "download_audio" =>"clips#download_audio"
    #resources :registrations
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
