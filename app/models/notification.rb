class Notification < ApplicationRecord
  include OrderableByTimestamp

  belongs_to :user
  belongs_to :sender, class_name: 'User'
  belongs_to :notifiable, polymorphic: true

  validates :user_id, uniqueness: { scope: %i[notifiable_id notifiable_type] }

  scope :num_of_new, -> { where(was_read: false).count }

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
end
