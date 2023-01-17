class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
  end

  def notifications
      @new = current_user.new_notifications
      @old = current_user.old_notifications
      @new.each(&:read)
  end
end
