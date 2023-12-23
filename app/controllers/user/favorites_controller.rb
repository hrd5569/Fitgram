class User::FavoritesController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_guest_user

  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
      current_user.favorites.destroy_by(id: params[:id])
      redirect_back(fallback_location: root_path)
  end
end

  private

  def ensure_guest_user
    redirect_to root_path, notice: "ゲストユーザーのため実行できません。" if current_user.email == "guest@example.com"
  end