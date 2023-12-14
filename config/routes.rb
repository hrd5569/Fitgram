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
    resources :users, only: [:show] do
      member do
        post 'follow', to: 'relationships#create', as: 'follow'
        delete 'unfollow', to: 'relationships#destroy', as: 'unfollow'
      end
    end

    get '/about', to: 'homes#about', as: 'about'
    get 'users/information/edit', to: 'users#edit', as: 'edit_information'
    patch 'users/information', to: 'users#update', as: 'update_information'
    get 'users/check', to: 'users#check', as: 'check_unsubscribe'
    patch 'users/withdraw', to: 'users#withdraw', as: 'withdraw_user_status'
    resources :posts do
    resources :comments, only: [:create, :destroy]
    end
    resources :favorites, only: [:create, :destroy]
  end

  # 管理者用
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '', to: 'homes#top', as: '/'
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:destroy]
    resources :comments, only: [:destroy]
  end

  root "user/homes#top"
end