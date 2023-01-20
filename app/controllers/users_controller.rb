class UsersController < ApplicationController
  def index
    @users = User.all.excluding(current_user).order('username ASC')
  end

  def show
    @user = User.find(params[:id])
    @profile = Profile.find_by(user_id: @user.id)
  end

  def notifications
      @new = current_user.new_notifications
      @old = current_user.old_notifications
      @new.each(&:read)
  end
end
