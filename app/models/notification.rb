class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  validates :user_id, uniqueness: { scope: %i[notifiable_id notifiable_type] }

  def message
    notifiable.message
  end

  def friend_request?
    notifiable_type == 'Friendship'
  end

  def read
    self.was_read = true
    save
  end

  def sender 
    @recipient ||= User.find(user_id)
    @sender ||= notifiable_type.constantize.find(notifiable_id).user

    if @recipient == @sender
      return Friendship.find(notifiable_id).friend
    end 
    @sender    
  end
end
