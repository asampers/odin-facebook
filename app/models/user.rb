class User < ApplicationRecord
  include Gravtastic
  gravtastic
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]
         
  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy 
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :reactions, dependent: :destroy

  has_many :friendships, ->(user) { FriendshipsQuery.both_ways(user_id: user.id) },
    inverse_of: :user,
    dependent: :destroy
  has_many :friends, ->(user) { UsersQuery.friends(user_id: user.id, scope: true) },
    through: :friendships
  has_many :inverse_friendships,  class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
  has_many :inverse_friends, through: :inverse_friendships, source: 'user'

  validates :username, presence: true, uniqueness: true

  attr_writer :login

  def login
    @login || username || email
  end 

  def received_request?(other_user)
    inverse_friends.include?(other_user)
  end 

  def active_friend_count
    self.friends.count - self.friendships.pending.count
  end

  def new_notifications
    notifications.order('created_at DESC').reject(&:was_read)
  end

  def old_notifications
    notifications.order('created_at DESC').select(&:was_read)
  end

  def find_friendship(other_user)
    self.friendships.find_by(friend: other_user) || self.friendships.find_by(user: other_user)
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
