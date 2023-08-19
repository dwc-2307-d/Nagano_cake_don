Rails.application.routes.draw do
  # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

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