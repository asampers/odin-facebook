class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.includes(:user).by_recently_created
    @post = current_user.posts.build
  end

  def show
    post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
  
    if @post.save 
      respond_to do |format|    
        format.html { redirect_to posts_path}
        format.turbo_stream { render turbo_stream: turbo_stream.prepend('posts', @post) }
      end  
    else  
      render :new, status: :unprocessable_entity
    end     
  end

  private 
  def post_params
    params.require(:post).permit(:body, :user_id)
  end
end
