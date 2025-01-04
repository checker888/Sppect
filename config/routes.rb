Rails.application.routes.draw do
  get 'accounts/show'
  get 'accounts/new'
  get 'accounts/edit'
  root "spaces#index"
  resource :account,except:[:destroy]
  resource :session, only:[:create,:destroy]


  resources :owners do
    resources :spaces 
  end
  
  resources :spaces do

  end
end
