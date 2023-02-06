class ReactionsController < ApplicationController
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

  def notify(user, reaction)
    return if current_user == user 

    user.notifications.create(notifiable: reaction)
  end

  def reaction_params
    params.require(:reaction).permit(:user_id, :reactable_id, :reactable_type)
  end
end
