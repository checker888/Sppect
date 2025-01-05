Rails.application.routes.draw do
  root "spaces#index"
  resource :account,except:[:destroy]
  resource :session, only:[:create,:destroy]
  resources :spaces,except:[:destroy] do
    resources :reservations,except:[:destroy]
  end
  # resources :reservations,except:[:destroy]
  resources :owners do
    resources :spaces
  end
  
  resources :users do
    resources :reservations
  end
end
