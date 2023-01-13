require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:jane) { create(:user, :jane) }
  let!(:john)  { create(:user, :john) }
  let!(:john_post) { john.posts.build("This is John's post.") }
  let!(:jane_comment) { john_post.build(user_id: jane.id, body: "Great post, John!")}
  let!(:john_comment) { jane_comment.comments.build(user_id: john, body: "Nice comment, Jane")}
  
end
