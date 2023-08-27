Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Devise routes for customers
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # Devise routes for admin
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # Public routes
  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    get "customers/mypage" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/information" => "customers#update"
    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "customers/withdraw" => "customers#withdraw"
    get "customers/about" => "homes/about"
    get '/customers/check' => 'customers#check'

    resources :items, only: [:index, :show] do
      collection do
        get :search
      end
     end

    resources :genres, only: [:show]
    resources :addresses, except: [:show]
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete :destroy_all
      end
    end
    resources :orders, only: [:new, :create, :index, :show] do
      collection do
        post "confirm"
        get "complete"
      end
    end
  end

  # Admin routes
  namespace :admin do
    get "/" => "orders#index"
    resources :items, except: [:destroy]
    resources :genres, except: [:new, :destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_items, only: [:update]
    resources :order_items, only: [:update]
  end
end
