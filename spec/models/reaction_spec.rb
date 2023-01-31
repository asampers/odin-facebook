require 'rails_helper'

RSpec.describe Reaction, type: :model do
  let!(:jane) { create(:user, :jane) }
  let!(:post) { FactoryBot.create(:post, user: jane) }
  let!(:post_reaction) { FactoryBot.create(:reaction, user: jane, reactable_id: post.id, reactable_type: post.class) }
  let!(:comment) { FactoryBot.create(:comment, user: jane, post: post) }
  let!(:comment_reaction) { FactoryBot.create(:reaction, user: jane, reactable_id: comment.id, reactable_type: comment.class) }
  
  describe "#message" do
    context 'inserts the correct reaction_type' do
      it 'is comment for comments' do 
        expect(comment_reaction.message).to eq(' liked your comment.')
      end 

      it 'is post for posts' do
        expect(post_reaction.message).to eq(' liked your post.')
      end  
    end
  end
end
