require 'rails_helper'

RSpec.describe "Friendships", type: :system do
  let!(:jane) { create(:user, :jane) }
  let!(:user) { create(:user, :faker) }
  let!(:john) { create(:user, :john) }
  let!(:friendship) { create(:friendship, user_id: jane.id, friend_id: john.id) }
  
   before do
    driven_by(:rack_test)
  end

  scenario "john accepts jane's friend request" do  
    login_as(john)
    visit '/users'
    expect(page).to have_content("Accept")
    expect(page).to have_content("Decline")

    click_on("Accept")
    expect(page).to have_content("Friend")
    expect(page).to have_content("Unfriend")
  end

  scenario "jane sends friend request to user" do 
    login_as(jane)
    visit '/users'
    expect(page).to have_selector(:link_or_button, "Add Friend")
    
    click_on("Add Friend")
    expect(page).to have_content("Pending")
    expect(page).to have_content("Unfriend")
  end   
end