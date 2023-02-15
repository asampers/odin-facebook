class CommentsController < ApplicationController
  before_action :set_post, only: %i[new create destroy]
  before_action :set_parent, only: %i[new]

  def create
    @comment = @post.comments.build(comment_params)

    if @comment.save
      notify(@post.user, @comment)
      respond_to do |format|
        format.html { redirect_to request.referrer }
        format.turbo_stream
      end  
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

  def set_parent
    return unless params.include?(:parent_id)

    @parent = Comment.find(params[:parent_id])
  end

  def notify(user, comment)
    user = comment.parent.user unless comment.parent.nil?
    return if current_user == user 

    user.notifications.create(notifiable: comment, sender: comment.user)
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id, :post_id, :parent_id)
  end
end
