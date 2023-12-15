class User::CommentsController < ApplicationController
  before_action :authenticate_user!


  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id

    if @comment.save
      redirect_to post_path(@post), notice: 'コメントを投稿しました。'
    else
      redirect_to post_path(@post), alert: 'コメントの投稿に失敗しました。'
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    if @comment
      @comment.destroy
      redirect_to post_path(params[:post_id]), notice: 'コメントを削除しました。'
    else
      redirect_to post_path(params[:post_id]), alert: 'コメントが見つかりませんでした。'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:reaction_comment)
  end
end