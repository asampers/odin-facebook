class UsersController < ApplicationController
  def index
    @users = User.excluding(current_user).order('username ASC')
  end

  def show
    @user = User.find(params[:id])
    @accepted_friends = @user.friendships.accepted.map(&:user) + @user.friendships.accepted.map(&:friend)
    @pending_friends = @user.friendships.pending.map(&:user) + @user.friendships.pending.map(&:friend)
    @profile = Profile.find_by(user_id: @user.id)
  end

  def notifications
      @new = current_user.new_notifications
      @old = current_user.old_notifications
      @new.each(&:read)
  end
end
