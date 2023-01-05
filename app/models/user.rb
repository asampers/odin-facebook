class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts 

  has_many :friendships, class_name: 'Friendship', foreign_key: 'user_id', dependent: :destroy
  has_many :friends, through: :friendships
  has_many :occurances_as_friend,  class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
  has_many :received_friend_requests, through: :occurances_as_friend, source: 'user'

  validates :username, presence: true, uniqueness: true

  attr_writer :login

  def login
    @login || username || email
  end 

  private

  def self.find_for_database_authentication(warden_condition)
    conditions = warden_condition.dup
    if(login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end    
end
