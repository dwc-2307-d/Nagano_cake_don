Rails.application.routes.draw do
  devise_for :customers
  devise_for :admins
  devise_for :users


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  #public用のルーティング
  scope module: :public do
    root to: "homes#top"
    get "about"=>"homes#about"
  end







  #管理者側のルーティング設定
  namespace :admin do
    resources :genres,except: [:new,:destroy]
  end
end