class User::PostsController < ApplicationController
  before_action :authenticate_user!

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

  def index
    @posts = Post.page(params[:page]).reverse_order
  end

  def show
    @post = Post.find(params[:id])
    @new_comment = Comment.new  # 新しいコメント用のインスタンス
    @comments = @post.comments  # 投稿に紐づくコメント
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def search
    @posts = Post.search(params[:search_type], params[:keyword])
  end

  def favorites
    @favorites_posts = current_user.favorited_posts.page(params[:page]).reverse_order
  end


  private
  def post_params
    params.require(:post).permit(:image, :image_title, :caption)
  end
end