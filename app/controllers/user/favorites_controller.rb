class User::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:create, :destroy]

  def create
      @post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js # JavaScript の応答を追加
    end
  end

  def destroy
      favorite = current_user.favorites.find_by(post_id: params[:post_id])
    favorite.destroy if favorite
    @post = Post.find(params[:post_id])
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js # JavaScript の応答を追加
    end
  end

  private

  def ensure_guest_user
    redirect_to root_path, notice: "ゲストユーザーのため実行できません。" if current_user.email == "guest@example.com"
  end
end