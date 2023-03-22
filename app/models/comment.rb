class Comment < ApplicationRecord
  include OrderableByTimestamp
  include OrderableByPopularity
  
  belongs_to :user
  belongs_to :post, counter_cache: true
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: :parent_id, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_many :reactions, as: :reactable, dependent: :destroy

  validates :user_id, presence: true
  validates :body, presence: true, length: { maximum: 250 }

  def message
    if parent_id.nil?
      " commented '<em>#{body.truncate(85)}</em>' <a href=/posts/#{self.post_id}?comment=#{self.id} target='_top'>on your post.</a>"
    else 
      " replied '<em>#{body.truncate(85)}</em>' <a href=/posts/#{self.post_id}?comment=#{self.parent_id} target='_top'>to your comment.</a>"  
    end 
  end     
end
