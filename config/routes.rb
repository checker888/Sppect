Rails.application.routes.draw do
  get 'login/index'
  root "spaces#index"
  resource :account,except:[:destroy]
  resource :owner_account, except:[:destroy]
  resource :session, only:[:create,:destroy]
  resource :owner_session, only:[:create,:destroy]
  resources :spaces,except:[:destroy] do
    resources :reservations,except:[:destroy]
    resources :reviews,except:[:destroy]
    patch "like","unlike",on: :member #ここはmemberでいい
    get "liked",on: :collection
  end
  # resources :reservations,except:[:destroy]
  resources :owners do
    resources :spaces
  end
  
  resources :users do
    resources :reservations
    resources :reviews
  end
end
