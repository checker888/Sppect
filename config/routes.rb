Rails.application.routes.draw do
  get 'login/index'
  get 'admin_login/index'
  root "spaces#index"
  resource :account
  resource :owner_account
  resource :session, only:[:create,:destroy]
  resource :owner_session, only:[:create,:destroy]
  resources :spaces do
    resources :reservations
    resources :reviews
    patch "like","unlike",on: :member #ここはmemberでいい
    get "liked",on: :collection
    get "search", on: :collection
    patch "public_available",on: :member
    patch "private_available",on: :member
  end
  # resources :reservations,except:[:destroy]
  resources :owners do
    resources :spaces do
      get "search", on: :collection
    end

  end
  resources :users do
    resources :reservations
    resources :reviews
    resources :spaces, only: [:index] do
      get "liked", on: :collection
    end
  end

  resources :reservations

  namespace :admin do
    get 'admins/index'
    get 'login/index'
    root "login#index"
    resource :admin_account
    resource :admin_session, only:[:create,:destroy]
    resources :admins
    resources :owners do
      resources :spaces do
        get "search", on: :collection
      end
  
    end
    resources :users do
      resources :reservations
      resources :reviews
      resources :spaces, only: [:index] do
        get "liked", on: :collection
      end
    end
    resources :spaces do
      resources :reservations
      resources :reviews
      get "search", on: :collection
      patch "public_available",on: :member
      patch "private_available",on: :member
      get "awaiting_approval",on: :collection
      patch "approve",on: :member
    end

    resources :genres
    resources :facilities
  end

end
