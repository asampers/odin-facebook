require 'rails_helper'

RSpec.describe Profile, type: :model do
  subject { build(:profile) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:user_id) }
end
