class User::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit, :update, :withdraw, :show]
  before_action :ensure_correct_user, only: [:edit, :update, :withdraw, :followings, :followers, :show]

    # ユーザーの情報をビューのレイアウトに表示
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
    @post_comments = Post.new
  end

    # ユーザー情報の編集
  def edit
    @user = User.find(params[:id])
  end

  def update
    # ユーザー情報の更新
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
  end


  def withdraw
    # ユーザーの退会処理
    @user = User.find(params[:id])
    @user.update(is_active: false)
    reset_session
    redirect_to root_path, notice: '退会処理が完了しました。'
  end

  def search
    @posts = Post.search(params[:name], params[:caption])
  end

  private
  def ensure_guest_user
    if current_user.email == "guest@example.com"
      redirect_to root_path, notice: "ゲストユーザーのため実行できません。"
    end
  end

  def ensure_correct_user
    # 現在のユーザーが対象ユーザーであるか確認
    @user = User.find(params[:id])
    redirect_to(root_path) unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:profile_image, :name, :age, :height, :weight, :gender)
  end

end