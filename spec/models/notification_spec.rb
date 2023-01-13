require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:jane) { create(:user, :jane) }
  let!(:john) { create(:user, :john) }
  let!(:friendship) { create(:friendship, user_id: jane.id, friend_id: john.id) }

  def jane_sends_john_request
    request = john.inverse_friendships.find_by(user: jane)
    john.notifications.create(notifiable: request)
  end

  def john_accepts_janes_request
    accept = jane.friendships.find_by(friend: john)
    accept.update_attribute(:status, 'accepted')
    jane.notifications.create(notifiable: accept)
  end

  describe '#message' do 
    before do
      jane_sends_john_request
    end
    
    it 'sends correct message according to notifiable type' do
      notification = john.notifications.last
      result = notification.message
      expect(result).to eq(" sent you a friend request - ")
    end
  end 

  describe '#friend_request?' do
    before do
      jane_sends_john_request
    end
    context 'it returns true when...' do
      it 'the notification is a friend request from other user' do
        notification = john.notifications.last
        result = notification.friend_request?
        expect(result).to be_truthy
      end
    end
  end

  describe '#sender' do
    before do
      jane_sends_john_request
      john_accepts_janes_request
    end
    it 'returns the name of user who sent the notification' do
      notification_1 = john.notifications.last
      notification_2 = jane.notifications.last
      result_1 = notification_1.sender
      result_2 = notification_2.sender
      expect(result_1).to eq(jane)
      expect(result_2).to eq(john)
    end
  end 
end
