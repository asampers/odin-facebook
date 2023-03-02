class ReactionsController < ApplicationController
  before_action :set_post, only: %i[index]
  before_action :set_reaction, only: %i[show destroy]

  def create
    @reaction = current_user.reactions.create(reaction_params)
    user = @reaction.reactable.user 
    
    if @reaction.save
      notify(user, @reaction)
      respond_to do |format|
        format.html { redirect_to request.referrer }
        format.turbo_stream
      end 
    else 
      flash[:alert] = @reaction.errors.full_messages.to_sentence
      redirect_to request.referrer  
    end   
  end

  def destroy
    @reaction.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.turbo_stream
    end  
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_reaction
    @reaction = current_user.reactions.find(params[:id])
  end
  
  def notify(user, reaction)
    return if current_user == user 

    user.notifications.create(notifiable: reaction, sender: reaction.user)
  end

  def reaction_params
    params.require(:reaction).permit(:user_id, :reactable_id, :reactable_type)
  end
end
