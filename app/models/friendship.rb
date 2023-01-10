class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
  enum :status, { pending: 0, accepted: 1, declined: 2}, default: :pending

  validates :user_id, :friend_id, :status, presence: true
end
