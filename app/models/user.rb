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
  has_many :sent_notifications, class_name: 'Notfication'
  has_many :reactions, dependent: :destroy

  has_many :friendships, ->(user) { FriendshipsQuery.both_ways(user_id: user.id) },
    inverse_of: :user,
    dependent: :destroy
  has_many :friends, ->(user) { UsersQuery.friends(user_id: user.id, scope: true) },
    through: :friendships
  has_many :inverse_friendships,  class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
  has_many :inverse_friends, through: :inverse_friendships, source: 'user'

  validates :username, presence: true, uniqueness: true

  after_create :send_welcome_email

  attr_writer :login

  def login
    @login || username || email
  end 

  def active_friend_count
    self.friends.count - self.friendships.pending.count
  end

  def new_notifications_size
    count = self.notifications.where(was_read: false).size
    return count if count > 0
  end 

  def find_friendship(other_user)
    self.friendships.find_by(friend: other_user) || self.friendships.find_by(user: other_user)
  end 

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name   
    end
  end

  private

  def send_welcome_email
    WelcomeMailer.welcome_email(self).deliver_now
  end

  def self.find_for_database_authentication(warden_condition)
    conditions = warden_condition.dup
    if(login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { value: login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end
end
