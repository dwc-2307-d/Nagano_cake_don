Rails.application.routes.draw do
  devise_for :customers
  devise_for :admins
  devise_for :users
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

  #public用のルーティング
  scope module: :pubic do
  end
  
  
  
  
  
  
  
  #管理者側のルーティング設定
  namespace :admin do
  end