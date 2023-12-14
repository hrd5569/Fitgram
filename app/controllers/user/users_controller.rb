class User::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]

 # ユーザーの情報をビューのレイアウトに表示
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
    @post_comments = Post.new
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end


  private
    def ensure_guest_user
      if current_user.email == "guest@example.com"
        redirect_to root_path, notice: "ゲストユーザーのため実行できません。"
      end
    end
end