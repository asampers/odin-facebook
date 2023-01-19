class ProfilesController < ApplicationController

  def new 
    @profile = current_user.build_profile
  end

  def create 
    @profile = current_user.create_profile(profile_params)

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
