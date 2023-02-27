class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show update]

  def create 
    @profile = current_user.build_profile(profile_params)

    if @profile.save
      flash[:notice] = "Successfully saved your profile."
      redirect_to user_path(current_user)
    end   
  end

  def edit; end 

  def update
    if @profile.update(profile_params)
      respond_to do |format|
        format.html { redirect_to request.referrer, notice: "Successfully updated your profile." }
        format.turbo_stream { flash.now[:notice] = "Successfully updated your profile." } 
      end 
    end   
  end 

  private

  def set_profile
    @profile ||= current_user.profile
  end 

  def profile_params
    params.require(:profile).permit(:user_id, :location, :age, :full_name, :bio)
  end
end
