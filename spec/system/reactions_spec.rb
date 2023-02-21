require 'rails_helper'

RSpec.describe "Reactions", type: :system do
  let!(:jane) { create(:user, :jane) }
  let!(:john) { create(:user, :john) }
  let!(:friendship) { create(:friendship, user_id: jane.id, friend_id: john.id, status: 'accepted') }
  let!(:jane_post) { FactoryBot.create(:post, user: jane) }
  
   before do
    driven_by(:rack_test)
  end

  context "john likes jane's post" do  
    before do 
      login_as(john)
      visit '/'
      click_on 'Like'
    end
    
    it 'creates a like for the post' do
      expect(jane_post.reactions.count).to eq(1)
    end  
    
    it 'creates a like for john' do
      expect(john.reactions.count).to eq(1)
    end 

    it 'shows that the post has 1 like' do 
      expect(page).to have_content '1 Like'
    end

    it 'shows the Unlike button' do
      expect(page).to have_button 'Unlike'
    end

    it 'displays the list of users who have liked' do
      click_on '1 Like'
      expect(page).to have_content 'Liked by:'
    end 
  end 

  context "john unlikes jane's post" do 
    before do
      login_as(john)
      visit '/'
      click_on 'Like'
    end

    it 'allows john to Like the post again' do 
      click_on 'Unlike'
      expect(page).to have_button 'Like'
    end

    it 'shows 0 Likes on the post' do
      click_on 'Unlike'
      expect(jane_post.reactions).to be_empty
    end
  end 
end