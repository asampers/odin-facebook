class NotificationsController < ApplicationController
  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.turbo_stream
    end  
  end
end
