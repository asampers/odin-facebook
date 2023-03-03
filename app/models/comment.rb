class Comment < ApplicationRecord
  include OrderableByPopularity
  
  belongs_to :user
  belongs_to :post, counter_cache: true
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :comments, foreign_key: :parent_id, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_many :reactions, as: :reactable, dependent: :destroy

  validates :user_id, presence: true
  validates :body, presence: true, length: { maximum: 250 }

  after_create_commit -> { broadcast_replace_to "collapseComment#{post.id} %>", locals: {post: self.post_id} }

  def message
    if parent_id.nil?
      " commented '<em>#{body.truncate(85)}</em>' on your post."
    else 
      " replied '<em>#{body.truncate(85)}</em>' to your comment."  
    end 
  end     
end
