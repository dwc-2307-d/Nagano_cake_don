Rails.application.routes.draw do
  devise_for :customers
  devise_for :admins
  devise_for :users

<<<<<<< HEAD

=======
>>>>>>> origin/feature/homes_layouts
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  #public用のルーティング
  scope module: :public do
    root to: "homes#top"
<<<<<<< HEAD
    get "about"=>"homes#about"
=======
    get "customers/about"=>"homes/about"
>>>>>>> origin/feature/homes_layouts
  end







  #管理者側のルーティング設定
  namespace :admin do
    resources :genres,except: [:new,:destroy]
  end
end