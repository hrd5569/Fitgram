Rails.application.routes.draw do
  # 会員用
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: 'user/sessions'
  }

  devise_scope :user do
    post 'user/guest_sign_in', to: 'user/sessions#guest_sign_in'
  end

  scope module: :user do
    # User関連
    resources :users, only: [:show, :update] do
      member do
        post 'follow', to: 'relationships#create', as: 'follow'
        delete 'unfollow', to: 'relationships#destroy', as: 'unfollow'
        get 'information/edit', to: 'users#edit', as: 'edit_user_information'
        patch 'information', to: 'users#update', as: 'update_user_information'
        patch 'users/withdraw', to: 'users#withdraw', as: 'withdraw_user_status'
      end

      # ユーザー検索機能のルーティングを追加
      collection do
        get 'search', to: 'users#search', as: 'search_users'
      end
    end

    # 投稿の検索機能
    get 'posts/search', to: 'posts#search', as: 'search_posts'

    # いいねした投稿一覧表示のルーティング
    get 'posts/favorites', to: 'posts#favorites', as: 'favorite_posts'

    # その他のルーティング
    get '/about', to: 'homes#about', as: 'about'
    get 'users/check', to: 'users#check', as: 'check_unsubscribe'
    resources :posts do
      resources :comments, only: [:create, :destroy]
    end
    resources :favorites, only: [:create, :destroy, :index]
  end

  # 管理者用
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '', to: 'homes#top', as: '/'
    resources :users, only: [:index, :edit, :show, :update, :destroy]
    resources :posts, only: [:destroy]
    resources :comments, only: [:destroy]
  end

  root "user/homes#top"
end