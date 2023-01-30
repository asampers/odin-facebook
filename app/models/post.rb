class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy 
  has_many :reactions, as: :reactable, dependent: :destroy 
  validates :body, :user_id, presence: true
end
