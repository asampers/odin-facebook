class FriendshipsController < ApplicationController

  def new
    @friendship = Friendship.new
  end

  def create
    @friend = User.find(params[:user_id])
    @friendship = Friendship.new(user: current_user, friend: @friend)
    
    if @friendship.save
      flash[:notice] = 'Friend request sent.'
    end  
  end

  def destroy
  end

  private

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end
end
