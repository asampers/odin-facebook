class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy, strict_loading: true 

  validates :body, :user_id, presence: true
end
