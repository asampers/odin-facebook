require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let!(:jane) { create(:user, :jane) }

   before do
    driven_by(:rack_test)
  end

  scenario 'user makes a post' do 
    login_as(jane)
    visit new_post_path(jane)
    fill_in "What's on your mind?", with: 'Test post'
    click_on 'Post'
    jane.reload
    post = jane.posts.last

    visit post_path(post)
    result = post.body == 'Test post'
    expect(page).to have_content('Test post')
    expect(result).to be_truthy
  end 

  scenario 'user fails to make a post' do 
    login_as(jane)
    visit new_post_path(jane)
    fill_in "What's on your mind?", with: ''
    click_on 'Post'
    
    expect(@post.errors).to eq(1)
    expect(page).to have_content("Body can't be black.")
  end 
end