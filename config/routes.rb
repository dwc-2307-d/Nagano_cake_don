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


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

 # 退会確認画面
 get  '/customers/check' => 'customers#check'
 # 論理削除用のルーティング
 patch  '/customers/withdraw' => 'customers#withdraw'



  #public用のルーティング
  scope module: :public do
    root to: "homes#top"

    get "about"=>"homes#about"
    get "customers/mypage" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/information" => "customers#update"
    get "customers/unsubscribe" => "customers#unsubscribe"
    patch "customers/withdraw" => "customers#withdraw"

    get "about"=>"homes#about"

    get "customers/about"=>"homes/about"

  end





  end



  #管理者側のルーティング設定
  namespace :admin do
    resources :items,except: [:destroy]
    resources :genres,except: [:new,:destroy]
    
    
  end
end