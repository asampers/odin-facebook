require 'rails_helper'

RSpec.describe Notification, type: :model do
  subject(:notification) { create(:notification, user: jane, notifiable: friendship, sender: john) }
  let!(:jane) { create(:user, :jane) }
  let!(:john) { create(:user, :john) }
  let!(:friendship) { create(:friendship, user_id: jane.id, friend_id: john.id) }

  def jane_sends_john_request
    request = john.inverse_friendships.find_by(user: jane)
    john.notifications.create(notifiable: request, sender: jane)
  end

  def john_accepts_janes_request
    accept = jane.friendships.find_by(friend: john)
    accept.update_attribute(:status, 'accepted')
    jane.notifications.create(notifiable: accept, sender: john)
  end

  context 'validations' do 
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:notifiable) }
    it { is_expected.to belong_to(:sender) }
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:notifiable_id, :notifiable_type) }
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

  describe '#read' do
    it 'updates the value of was_read to true' do
      result = notification.read
      expect(result).to be_truthy
    end
  end

end
