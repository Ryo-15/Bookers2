Rails.application.routes.draw do
  # deviseを使用する際にURLとしてusersを含む
  # コントローラのカスタマイズ反映(ログイン後画面遷移)
  devise_for :users, controllers: { registrations: 'users/registrations',sessions: 'users/sessions' }
  # ルートパス設定
  get '/' => 'books#top', as: 'root'
  get 'home/about' => 'books#about'

  # resources=ルーティングを一括して自動生成 only=生成するルーティングを限定
  resources :books, only:[:index, :show, :edit, :new, :create, :update, :destroy] do
    # いいね機能をネスト関係で追加（単数にすると、そのコントローラのidがリクエストに含まれなくなる）
    # showページが不要で、idの受け渡しも必要ないので、resource
    resource :favorites, only:[:create, :destroy]
    resource :book_comments, only:[:create, :destroy]
  end

    resources :users, only:[:index, :show, :edit, :new, :create, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
