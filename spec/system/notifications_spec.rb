require 'rails_helper'

RSpec.describe "Notifications", type: :system do
  let!(:jane) { create(:user, :jane) }
  let!(:john) { create(:user, :john) }
  let!(:friendship) { create(:friendship, user_id: jane.id, friend_id: john.id) }
  let!(:post) { FactoryBot.create(:post, user: jane) }
  let!(:comment) { create(:comment, user_id: john.id, post_id: post.id)}
  let!(:notification1) { create(:notification, user: jane, notifiable: friendship, sender: john) }
  let!(:notification2) { create(:notification, user:jane, notifiable: comment, sender: john)}

  scenario "user has no notifications" do  
    login_as(john)
    visit "users/#{john.id}/notifications"
    expect(page).to have_content("You have no notifications!")
  end

  scenario "user deletes notifications one by one" do 
    login_as(jane)
    visit "users/#{jane.id}/notifications"
    expect(page).to have_content("New")
    expect(jane.notifications.count).to eq(2)
    click_on 'Manage Notifications'
    click_on 'Delete Some'
    first('button#notification-manager').click
    expect(jane.reload.notifications.reload.count).to eq(1)

    first('button#notification-manager').click
    expect(jane.reload.notifications.count).to eq(0)
    expect(page).to have_content("You have no notifications!")
  end

  scenario "user deletes all notifications at once" do 
    login_as(jane)
    visit "users/#{jane.id}/notifications"
    expect(page).to have_content("New")
    expect(jane.notifications.count).to eq(2)
    click_on 'Manage Notifications'
    accept_confirm do
      click_on 'Delete All'
    end  

    expect(jane.reload.notifications.count).to eq(0)
    expect(page).to have_content("You have no notifications!")
  end
end