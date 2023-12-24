class User::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  # フォローする
  def create
    other_user = User.find(params[:id])
    current_user.follow(other_user)
    redirect_back(fallback_location: root_path)
  end

  # フォロー解除する
  def destroy
    other_user = User.find(params[:id])
    current_user.unfollow(other_user)
    redirect_back(fallback_location: root_path)
  end

  private

  def ensure_guest_user
    redirect_to root_path, notice: "ゲストユーザーのため実行できません。" if current_user.email == "guest@example.com"
  end
end