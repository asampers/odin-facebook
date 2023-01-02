require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { build(:post) }
  
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_presence_of(:user_id) }
  end 
end
