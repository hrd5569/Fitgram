class User::PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

def create
  @post = Post.new(post_params)
  @post.user_id = current_user.id

  # 画像が選択されているかチェック
  if post_params[:image].blank?
    @post.errors.add(:image, '画像を選択してください')
    render :new and return
  end

  # 画像が選択されている場合の処理
  labels = Vision.get_image_data(post_params[:image])

  if @post.save
    labels.each do |label|
      tag = Tag.find_or_create_by(name: label)
      PostTag.create(post_id: @post.id, tag_id: tag.id)
    end
    redirect_to posts_path
  else
    render :new
  end
end

  def index
    @posts = Post.page(params[:page]).per(5).reverse_order
    @user = current_user
  end

  def show
    @post = Post.find(params[:id])
    @new_comment = Comment.new
    @comments = @post.comments.page(params[:page]).per(5)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def search
    @posts = Post.search(params[:search_type], params[:keyword]).page(params[:page]).per(5)
    @user = current_user
  end

  def favorites
    @favorites_posts = current_user.favorited_posts.page(params[:page]).per(5).reverse_order
  end


  private
  def post_params
    params.require(:post).permit(:image, :image_title, :caption)
  end
end