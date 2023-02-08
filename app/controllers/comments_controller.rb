class CommentsController < ApplicationController
  before_action :set_post, only: %i[create destroy]

  def create
    @comment = @post.comments.build(comment_params)

    if @comment.save
      
      notify(@post.user, @comment)
      redirect_to request.referrer
    else  
      flash[:alert] = "Unable to save comment."
      redirect_to request.referrer 
    end   
  end

  def destroy
    @comment = @post.comments.includes(:notifications, {reactions:[:notifications]}).find(params[:id])
    @comment.destroy
    
    respond_to do |format|
      format.html { redirect_to request.referrer, flash[:notice] = "Comment deleted." }
      format.turbo_stream
    end  
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
