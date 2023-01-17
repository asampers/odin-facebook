class ProfilesController < ApplicationController

  def create 
    @profile = current_user.profile.build(profile_params)

    if @profile.save
      flash[:notice] = "Successfully updated your profile"
      redirect_to user_path(current_user)
    else  
      flash[:alert] = "Unable to update profile."
      redirect_to user_path(current_user) 
    end   
  end

  private

  def profile_params
    params.require(:profile).permit(:user_id, :location, :age, :full_name, :bio)
  end
end
