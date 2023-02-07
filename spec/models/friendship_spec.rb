require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let!(:jane) { create(:user, :jane) }
  let!(:john) { create(:user, :john) }
  let!(:friendship) { create(:friendship, user_id: jane.id, friend_id: john.id) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:friend_id) } 
  end 

  describe '#message' do 
    it 'displays correctly for a declined friendship' do
      friendship.update_attribute(:status, 'declined')
      expect(friendship.message).to eq(' unfriended you.')
    end

    it 'displays correctly for an accepted friendship' do
      friendship.update_attribute(:status, 'accepted')
      expect(friendship.message).to eq(" and you are now friends.")
    end
  end
end
