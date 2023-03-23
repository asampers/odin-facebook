require 'rails_helper'

RSpec.describe "Post Index", type: :system do  
  let!(:jane) { create(:user, :jane) }
  let!(:user) { create(:user, :faker) }
  let!(:john) { create(:user, :john) }
  let!(:friendship) { create(:friendship, user_id: jane.id, friend_id: john.id, status: 'accepted') }
  let!(:jane_post) { FactoryBot.create(:post, user: jane) }
  let!(:john_post) { FactoryBot.create(:post, user: john) }
  let!(:user_post) { FactoryBot.create(:post, user: user) }

  context 'user feed when a user has friends' do
    it 'shows posts written by user and friends' do
      login_as(jane)
      visit root_path
      
      expect(page).to have_content('Displaying all 2 posts')
    end
  end

  context 'user feed when a user has no friends' do
    it "shows just the user's posts" do
      login_as(user)
      visit root_path

      expect(page).to have_content('Displaying 1 post')
    end
  end

  context 'all posts page' do 
    it 'shows all posts for all users' do
      login_as(jane)
      visit root_path
      click_on("All Posts")
      expect(page).to have_content('Displaying all 3 posts')
      
      login_as(user)
      visit root_path
      click_on("All Posts")
      expect(page).to have_content('Displaying all 3 posts')
    end
  end
end  