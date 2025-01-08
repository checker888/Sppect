Rails.application.routes.draw do
  get 'login/index'
  root "spaces#index"
  resource :account
  resource :owner_account
  resource :session, only:[:create,:destroy]
  resource :owner_session, only:[:create,:destroy]
  resources :spaces do
    resources :reservations,except:[:destroy]
    resources :reviews
    patch "like","unlike",on: :member #ここはmemberでいい
    get "liked",on: :collection
    get "search", on: :collection
    patch "public_available",on: :member
    patch "private_available",on: :member
  end
  # resources :reservations,except:[:destroy]
  resources :owners do
    resources :spaces
  end
  resources :users do
    resources :reservations
    resources :reviews
    resources :spaces, only: [:index] do
      get "liked", on: :collection
    end
  end
end
