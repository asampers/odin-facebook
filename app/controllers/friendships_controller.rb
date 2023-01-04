class FriendshipsController < ApplicationController

  def new
    @friendship = Friendship.new
  end

  def create
    @user = User.find(params[:user_id])
    @friendship = Friendships.new(user: current_user, friend_id: @user )
    if @friendship.save
      redirect_to request.referrer
    end  
  end

  def destroy
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end
end
