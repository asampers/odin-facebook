class PostsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @posts = if params[:all_posts] == 'true'
              Post.includes(:user).by_recently_created.page(page).per(10)
            else
              Post.where(user: (User.find(current_user.friendships.accepted.pluck(:user_id, :friend_id)))).or(Post.where(user: current_user)).includes(:user).by_recently_created.page(page).per(10) 
            end 
    @title = if request.original_url.include?('true') 
              "All Posts"
            else 
              "#{current_user.username}'s Feed"
            end     
  end  

  def show
    @post = Post.find(params[:id])
    @comment = Comment.find(params[:comment]) if params[:comment]
  end

  def new
    @post = current_user.posts.build  
  end

  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save 
      respond_to do |format|    
        format.html { redirect_to posts_path}
        format.turbo_stream
      end  
    else  
      render :new, status: :unprocessable_entity
    end     
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.turbo_stream
    end
  end  

  private 

  def post_params
    params.require(:post).permit(:body, :user_id)
  end

  def page
    params.fetch(:page, 1).to_i
  end
end
