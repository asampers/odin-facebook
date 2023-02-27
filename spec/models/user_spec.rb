require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }
  let!(:jane) { create(:user, :jane) }
  let!(:john) { create(:user, :john) }
  let!(:user) { create(:user, :faker) }
  let!(:pending_friendship) { create(:friendship, user_id: john.id, friend_id: jane.id, status: 'pending') }
  let!(:accepted_friendship) { create(:friendship, user_id: user.id, friend_id: jane.id, status: 'accepted') }

  it { is_expected.to have_many(:friendships).dependent(:destroy) }
  it { is_expected.to have_many(:friends) }
  it { is_expected.to have_many(:inverse_friendships).dependent(:destroy) }
  it { is_expected.to have_many(:inverse_friends) }
  
  it { is_expected.to have_many(:posts).dependent(:destroy) }
  it { is_expected.to have_many(:comments).dependent(:destroy) }
  it { is_expected.to have_many(:reactions).dependent(:destroy) }
  it { is_expected.to have_many(:notifications).dependent(:destroy) }
  it { is_expected.to have_one(:profile).dependent(:destroy) }
  it { is_expected.to validate_uniqueness_of(:username) }

  it "sends a welcome email" do
    expect { create(:user) }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  describe "#active_friend_count" do
    it 'displays the number of accepted friends only' do
      expect(jane.active_friend_count).to eq(1)
    end  
  end
end
