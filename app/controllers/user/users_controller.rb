class User::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit, :update]

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

  def search
    @posts = Post.search(params[:name], params[:caption])
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_active: false)
    reset_session # ユーザーセッションをリセット
    redirect_to root_path, notice: '退会処理が完了しました。'
  end

  private
    def ensure_guest_user
      if current_user.email == "guest@example.com"
        redirect_to root_path, notice: "ゲストユーザーのため実行できません。"
      end
    end

  def user_params
    params.require(:user).permit(:profile_image, :name, :age, :height, :weight, :gender)
  end

end