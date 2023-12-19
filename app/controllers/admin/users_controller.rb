class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def search
    # 検索パラメータを使用してユーザーを検索
    @users = User.search_by_name(params[:name])
    render :index # 検索結果を index ビューで表示
  end

  def show
    @user
    # @user は set_user before_action によってセットされる
  end

  def edit
    @user
    # @user は set_user before_action によってセットされる
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'ユーザー情報を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'ユーザーを削除しました'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :age, :height, :weight, :gender)
  end
end