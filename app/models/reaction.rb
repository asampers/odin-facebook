class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :reactable, polymorphic: true, counter_cache: :reactions_count
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :user_id, uniqueness: { scope: %i[reactable_id reactable_type] }

  def message
    " liked your '<em>#{reactable.body.truncate(25)}</em>' <a href=#{link_helper()} target='_top'>#{reactable_type.downcase}.</a>"
  end

  def link_helper
    if reactable_type == "Comment"
      "/posts/#{self.reactable.post_id}/?comment=#{reactable_id} "
    elsif reactable_type == "Post"
      "/posts/#{reactable_id}"
    end  
  end
end
