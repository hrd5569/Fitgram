Rails.application.routes.draw do

  # 会員用
  #devise_for :テーブル名でURLを変更
  #skip:パスワード変更のコントローラを削除
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  #scope moduleと付けることでURLとファイル構成を指定
  #URLのパスは変わらず、Controller#Actionの表記がuser/resorces/アクションになる
  scope module: :user do
    # User関連
  end












  # 管理者用
  ##devise_for :テーブル名でURLを変更
  #skip:で新規登録とパスワード変更のコントローラを削除
  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  #namespaceはURLとファイル構成を指定
  namespace :admin do
    # Admin関連
  end

  # root "homes#top"
end
