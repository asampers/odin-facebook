class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show update]

  def new 
    @profile = current_user.build_profile
  end

  def create 
    @profile = current_user.build_profile(profile_params)

    if @profile.save
      flash[:notice] = "Successfully saved your profile."
      redirect_to user_path(current_user)
    else  
      flash[:alert] = "Unable to save profile."
      redirect_to user_path(current_user) 
    end   
  end

  def edit; end 

  def update
    if @profile.update(profile_params)
      flash[:notice] = "Successfully updated your profile."
      redirect_to user_path(current_user)
    else 
      flash[:alert] = "Unable to update profile."
      render :edit, status: :unprocessable_entity 
    end   
  end 

  private

  def set_profile
    @profile = current_user.profile
  end 

  def profile_params
    params.require(:profile).permit(:user_id, :location, :age, :full_name, :bio)
  end
end
