class User::FavoritesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    redirect_to post_path(post)
  end

  def destroy
    post = Post.find_by(id: params[:post_id])
      current_user.favorites.destroy_by(post_id: post.id)
      redirect_to post_path(post)
  end
end
