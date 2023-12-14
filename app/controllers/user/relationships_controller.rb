class User::RelationshipsController < ApplicationController
  # フォローする
  def create
    other_user = User.find(params[:id])
    current_user.follow(other_user)
    # リダイレクトやフラッシュメッセージなどの処理
    redirect_to posts_path
  end

  # フォロー解除する
  def destroy
    other_user = User.find(params[:id])
    current_user.unfollow(other_user)
    # リダイレクトやフラッシュメッセージなどの処理
    redirect_to posts_path
  end
end