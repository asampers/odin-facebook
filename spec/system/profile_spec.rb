require 'rails_helper'

RSpec.describe "Profile", type: :system do
  let!(:jane) { create(:user, :jane) }
  let!(:john) { create(:user, :john) }
  let!(:john_profile) { FactoryBot.create(:profile, user: john)}

  scenario 'user makes their profile' do 
    login_as(jane)
    visit user_path(jane)
    click_on 'About'
    expect(page).to have_content("Feel free to add your profile info.")
    expect(page).to have_content("Full name\nLocation\nAge\nBio")

    fill_in "Full name", with: "Jane"
    fill_in "Location", with: "Here"
    fill_in "Bio", with: "Having fun."
    click_button 'Save'
    
    expect(page).to have_content('Successfully saved your profile.')
    expect(jane.profile.full_name).to eq("Jane")
    expect(jane.profile.location).to eq("Here")
    expect(jane.profile.bio).to eq("Having fun.")
    expect(page).to have_selector(:link_or_button, "Edit")
  end 

  scenario 'user updates their profile' do
    login_as(john)
    visit user_path(john)
    click_on 'About'
    expect(page).to have_content("Name: John\nAge: 25\nLocation: New York\nBio: There's nothing to tell.")

    click_on "Edit"
    fill_in "Location", with: "California"
    fill_in "Bio", with: "So many secrets"
    click_button 'Save'

    expect(page).to have_content('Successfully updated your profile.')
    john.profile.reload
    expect(john.profile.location).to eq("California")
    expect(john.profile.bio).to eq("So many secrets")
  end
end