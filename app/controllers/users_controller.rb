class UsersController < ApplicationController
  def index
    @users = User.excluding(current_user).order('username ASC')
  end

  def show
    @user ||= User.find(params[:id])
    @accepted_friends = @user.friendships.includes(:user).accepted.map(&:user) + @user.friendships.includes(:friend).accepted.map(&:friend)
    @pending_friends = @user.friendships.includes(:user).pending.map(&:user) + @user.friendships.includes(:friend).pending.map(&:friend)
  end

  def notifications
      @new ||= current_user.notifications.includes(:notifiable).by_recently_created.where(was_read: false)
      @old ||= current_user.notifications.includes(:notifiable).by_recently_created.where(was_read: true)
  end
end
