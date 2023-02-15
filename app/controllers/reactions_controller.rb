class ReactionsController < ApplicationController
  before_action :set_post, only: %i[index]
  
  def create
    @reaction = current_user.reactions.create(reaction_params)
    user = @reaction.reactable.user 
    
    if !@reaction.save
      flash[:alert] = @reaction.errors.full_messages.to_sentence
    end 
    
    notify(user, @reaction)
    redirect_to request.referrer   
  end

  def destroy
    @reaction = current_user.reactions.find(params[:id])
    @reaction.destroy
    redirect_to request.referrer
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
  
  def notify(user, reaction)
    return if current_user == user 

    user.notifications.create(notifiable: reaction, sender: reaction.user)
  end

  def reaction_params
    params.require(:reaction).permit(:user_id, :reactable_id, :reactable_type)
  end
end
