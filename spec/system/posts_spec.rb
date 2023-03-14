require 'rails_helper'

RSpec.describe "Posts", type: :system do
  let!(:jane) { create(:user, :jane) }

  scenario 'user makes a post' do 
    login_as(jane)
    visit root_path
    fill_in "What's on your mind?", with: 'Test post'
    click_on 'Post'
    visit root_path
    jane.reload
    post = jane.posts.last
    result = post.body == 'Test post'

    expect(page).to have_content('Test post')
    expect(result).to be_truthy
  end 

  scenario 'user fails to make a post' do 
    login_as(jane)
    visit root_path
    fill_in "What's on your mind?", with: ''
    click_on 'Post'
    expect(page).to have_content("Body can't be blank")
  end 
end