class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy 

  validates :body, :user_id, presence: true
end
