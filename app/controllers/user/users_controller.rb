class User::UsersController < ApplicationController
  before_action :ensure_guest_user, except: [:new, :edit]

 # ユーザーの情報をビューのレイアウトに表示
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).reverse_order
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
      @user = User.find(params[:id])
    #   if @user.email == "guest@example.com"
    #     redirect_to user_path, notice: "ゲストユーザーのため実行できません。"
    # end
    end
end