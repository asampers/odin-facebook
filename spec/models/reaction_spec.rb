require 'rails_helper'

RSpec.describe Reaction, type: :model do
  let!(:jane) { create(:user, :jane) }
  let!(:post) { FactoryBot.create(:post, user: jane) }
  let!(:post_reaction) { FactoryBot.create(:reaction, user: jane, reactable_id: post.id, reactable_type: post.class) }
  let!(:comment) { FactoryBot.create(:comment, user: jane, post: post) }
  let!(:comment_reaction) { FactoryBot.create(:reaction, user: jane, reactable_id: comment.id, reactable_type: comment.class) }
  
  context 'validations' do 
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:reactable) }
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:reactable_id, :reactable_type) }
  end 

  describe "#message" do
    context 'inserts the correct reaction_type' do
      it 'is comment for comments' do 
        expect(comment_reaction.message).to eq(" liked your '<em>#{comment_reaction.reactable.body.truncate(25)}</em>' <a href=/posts/#{comment_reaction.reactable.post_id}/?comment=#{comment_reaction.reactable_id}  target='_top'>#{comment_reaction.reactable_type.downcase}.</a>")
      end 

      it 'is post for posts' do
        expect(post_reaction.message).to eq(" liked your '<em>#{post_reaction.reactable.body.truncate(25)}</em>' <a href=/posts/#{post_reaction.reactable_id} target='_top'>#{post_reaction.reactable_type.downcase}.</a>")
      end  
    end
  end
end
