require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let!(:jane) { create(:user, :jane) }

  scenario 'user makes a post' do 
    login_as(jane)
    visit root_path
    fill_in "What's on your mind?", with: 'Test post'
    click_on 'Post'
    jane.reload
    post = jane.posts.last

    result = post.body == 'Test post'
    expect(page).to have_content('Test post')
    expect(result).to be_truthy
  end  
end