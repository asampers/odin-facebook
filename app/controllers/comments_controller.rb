class CommentsController < ApplicationController
  before_action :set_post, only: %i[create destroy]

  def create
    @comment = @post.comments.build(comment_params)

    if @comment.save
      notify(@post.user, @comment)
      redirect_to post_path(@post)
    else  
      flash[:alert] = "Unable to save comment."
      redirect_to post_path(@post) 
    end   
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comment deleted."
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def notify(user, comment)
    user = comment.parent.user unless comment.parent.nil?
    return if current_user == user 

    user.notifications.create(notifiable: comment)
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :parent_id)
  end
end
