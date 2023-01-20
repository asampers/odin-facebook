class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[edit update]

  def new 
    @profile = current_user.build_profile
  end

  def create 
    @profile = current_user.build_profile(profile_params)

    if @profile.save
      flash[:notice] = "Successfully updated your profile"
      redirect_to user_path(current_user)
    else  
      flash[:alert] = "Unable to update profile."
      redirect_to user_path(current_user) 
    end   
  end

  def edit; end 

  def update
    if @profile.update(profile_params)
      redirect_to user_path(current_user)
    else 
      render :edit, status: :unprocessable_entity 
    end   
  end 

  private

  def set_profile
    @profile = Profile.find_by(params[user_id: current_user.id])
  end 

  def profile_params
    params.require(:profile).permit(:user_id, :location, :age, :full_name, :bio)
  end
end
