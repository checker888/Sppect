Rails.application.routes.draw do
  root "spaces#index"
  resource :session, only:[:create,:destroy]


  resources :owners do
    resources :spaces 
  end
  

end
