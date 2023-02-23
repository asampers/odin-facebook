class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :reactable, polymorphic: true, counter_cache: :reactions_count
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :user_id, uniqueness: { scope: %i[reactable_id reactable_type] }

  def message
    " liked your '<em>#{reactable.body.truncate(85)}</em>' #{reactable_type.downcase}."
  end
end
