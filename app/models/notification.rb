class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  validates :user_id, uniqueness: { scope: %i[notifiable_id notifiable_type] }

  def message
    notifiable.message
  end

  def friend_request?
    return unless notifiable_type == 'Friendship'

    friendship = Friendship.find(notifiable_id)
    user.received_request?(friendship)
  end

  def read
    self.was_read = true
  end

  def sender
    notifiable_type.constantize.find(notifiable_id).user
  end

  private

  def load_notifiable
    resource, id = request.path.split('/')[1, 2]
	  @notifiable = resource.singularize.classify.constantize.find(id)
  end
end
