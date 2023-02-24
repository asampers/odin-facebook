class NotificationsController < ApplicationController
  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.turbo_stream
    end  
  end

  def destroy_multiple
    Notification.where(user_id: params[:user_id]).delete_all
    redirect_to request.referrer
  end
end
