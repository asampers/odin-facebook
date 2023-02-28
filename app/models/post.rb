class Post < ApplicationRecord
  include OrderableByTimestamp

  belongs_to :user
  has_many :comments, dependent: :destroy 
  has_many :reactions, as: :reactable, dependent: :destroy 
  validates :body, :user_id, presence: true

  scope :popular, -> { order(reactions_count: :desc).limit(5)}
end
