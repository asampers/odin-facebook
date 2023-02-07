require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:comment) { create(:comment) }

  let!(:jane) { create(:user, :jane) }
  let!(:post) { FactoryBot.create(:post, user: jane) }
  let!(:comment) { create(:comment, user: jane, post: post, parent_id: nil) }
  let!(:nested_comment) { create(:comment, user: jane, post: post, parent_id: 1) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:parent).optional }
  it { is_expected.to have_many(:comments).dependent(:destroy) }
  it { is_expected.to have_many(:reactions).dependent(:destroy) }
  it { is_expected.to have_many(:notifications).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:user_id) }

  describe '#message' do 
    it 'displays correctly for comment without parent' do
      expect(comment.message).to eq(' commented on your post.')
    end
  end
end
