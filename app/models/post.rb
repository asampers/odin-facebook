class Post < ApplicationRecord
  include OrderableByTimestamp
  include OrderableByPopularity

  belongs_to :user
  has_many :comments, dependent: :destroy 
  has_many :reactions, as: :reactable, dependent: :destroy 
  validates :body, :user_id, presence: true

  after_create_commit -> { broadcast_prepend_to "posts", partial: "posts/post", locals: { post: self }, target: "posts" }
end
