require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

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
end
