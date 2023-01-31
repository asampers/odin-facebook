class ReactionsController < ApplicationController
  def create
    @reaction = current_user.reactions.create(reaction_params)

    if !@reaction.save
      flash[:alert] = @reaction.errors.full_messages.to_sentence
    end 

    redirect_to request.referrer   
  end

  def destroy
    @reaction = current_user.reactions.find(params[:id])
    @reaction.destroy
    redirect_to request.referrer
  end

  private

  def reaction_params
    params.require(:reaction).permit(:user_id, :reactable_id, :reactable_type)
  end
end
