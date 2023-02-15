class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.includes(:user).order(created_at: :desc)
    @reactions = current_user.reactions
  end

  def show
    post = Post.find(params[:id]).includes(:comments, :reactions)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save     
      redirect_to posts_path
    else  
      render :new, status: :unprocessable_entity
    end     
  end

  private 
  def post_params
    params.require(:post).permit(:body, :user_id)
  end
end
