Rails.application.routes.draw do

  # 会員用
  #devise_for :テーブル名でURLを変更
  #skip:パスワード変更のコントローラを削除
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  #scope moduleでURLとファイル構成を指定
  scope module: :user do
    # User関連
    get '/about', to: 'homes#about', as: 'about'
    # users/editにするとdeviseのルーティングと重複するためinformationを付けている。
    # 会員情報の編集
    get 'users/information/edit', to: 'users#edit', as: 'edit_information'
    patch 'users/information', to: 'users#update', as: 'update_information'
    # 会員のマイページ
    get 'users/mypage/show', to: 'users#show', as: 'user_mypage'

    # 退会確認 checkアクション
    get 'users/check', to: 'users#check', as: 'check_unsubscribe'
    # 会員ステータス変更 withdrawアクション
    patch 'users/withdraw', to: 'users#withdraw', as: 'withdraw_user_status'

    # 投稿機能 新規投稿:new, :create 投稿一覧:index 投稿詳細:show 投稿削除:destroy
    resources :posts, only: [:new, :create, :index, :show, :destroy]
    # いいね機能
    resources :favorites, only: [:create, :destroy]
    # コメント機能
    resources :comments, only: [:create, :destroy]

    # フォロー、フォロワー機能
    # memberブロックを使用するとURLに特定の識別子が追加される
    # （例）/users/:user_id/followings
    resources :relationships, only: [:create, :destroy] do
      member do
        get 'followings'
        get 'followers'
      end
    end
  end


  # 管理者用
  ##devise_for :テーブル名でURLを変更
  #skip:で新規登録とパスワード変更のコントローラを削除
  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }


  #namespaceでURLとファイル構成を指定
  namespace :admin do
    # Admin関連
    get '', to: 'homes#top', as: '/'
    # 会員一覧、会員詳細、会員情報編集、会員情報更新
    resources :users, only: [:index, :show, :edit, :update]
    # 会員投稿削除
    resources :posts, only: [:destroy]
    # 会員コメント削除
    resources :comments, only: [:destroy]
  end
    root "user/homes#top"
end