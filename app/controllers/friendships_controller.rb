class FriendshipsController < ApplicationController

  def new
    @friendship = Friendship.new
  end

  def create
    @user = User.find(params[:user_id])
    @friendship = current_user.friendships.build(friend: @user)
    notify(@user, @friendship)

    if @friendship.save
      flash[:notice] = 'Friend request sent.'
      redirect_to request.referrer
    else
      flash[:alert] = 'Unable to add friend.'
      redirect_to request.referrer  
    end  
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update_attribute(:status, 'accepted')
    notify(@friendship.user, @friendship)
    flash[:notice] = "You are now friends with #{@friendship.user.username}!"
      redirect_to request.referrer
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @former_friend = select_friend(@friendship).username
    @friendship.destroy
    flash[:notice] = "You are no longer friends with #{@former_friend}"
    redirect_to request.referrer 
  end

  private

  def select_friend(friendship)
    friendship.friend == current_user ? friendship.user : friendship.friend
  end 

  def notify(user, friendship)
    user.notifications.create(notifiable: friendship)
  end

  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end
end
