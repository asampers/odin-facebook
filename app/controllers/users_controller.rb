class UsersController < ApplicationController
  def index
    @users = User.excluding(current_user).order('username ASC')
  end

  def show
    @user = User.includes({posts:[{reactions:[:user]}]}).find(params[:id])
    @accepted_friends = @user.friendships.includes(:user).accepted.map(&:user) + @user.friendships.includes(:friend).accepted.map(&:friend)
    @pending_friends = @user.friendships.includes(:user).pending.map(&:user) + @user.friendships.includes(:friend).pending.map(&:friend)
    @profile = Profile.find_by(user_id: @user.id)
  end

  def notifications
      @new = current_user.new_notifications
      @old = current_user.old_notifications
      @new.each(&:read)
  end
end
