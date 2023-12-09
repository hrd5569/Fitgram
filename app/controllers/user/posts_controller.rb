class User::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  # 投稿データの保存
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  #↓kaminari入れないとエラー？
  def index
    @post = Post.page(params[:page]).reverse_order
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  # 投稿データのストロングパラメータ
  private

  def posts_params
    params.require(:image).permit(:image, :image_title, :caption)
  end

end
