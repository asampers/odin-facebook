class UsersController < ApplicationController
  def index
    @users = User.excluding(current_user).order('username ASC')
  end

  def show
    @user ||= User.find(params[:id])
    @posts = @user.posts.by_recently_created
    @accepted_friends = User.find(@user.friendships.accepted.pluck(:user_id, :friend_id))
    @pending_friends = User.find(@user.friendships.pending.pluck(:user_id, :friend_id))
    @num_of_friends = @accepted_friends.reject{|user| user == @user}.size
  end

  def notifications
      @new ||= current_user.notifications.includes(:notifiable).by_recently_created.where(was_read: false)
      @old ||= current_user.notifications.includes(:notifiable).by_recently_created.where(was_read: true)
  end
end
