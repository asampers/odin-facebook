require 'rails_helper'

RSpec.describe "Comments", type: :system do
  let!(:jane) { create(:user, :jane) }
  let!(:john) { create(:user, :john) }
  let!(:jane_post) { FactoryBot.create(:post, user: jane) }

  def john_comments
    login_as(john)
    visit root_path
    find(:css, ".commenting").click
    fill_in "Enter your text here...", with: 'Great post, Jane!'
    find(".submit").click
  end

  scenario "john comments on jane's post" do 
    john_comments()
    click_on '1 Comment'
    
    expect(page).to have_content('Great post, Jane!')
    expect(jane_post.comments.count).to eq(1)
  end 

  scenario "john deletes his comment on jane's post" do 
    john_comments()
    click_on '1 Comment'
    click_on 'Delete'
    expect(page).to have_content('0 Comments')
    expect(jane_post.comments.count).to eq(0)
  end

  scenario "john fails to comment on jane's post" do 
    login_as(john)
    visit root_path
    find(:css, ".commenting").click
    fill_in "Enter your text here...", with: ''
    find(".submit").click
    
    expect(page).to have_content("Body can't be blank")
    expect(jane_post.comments.count).to eq(0)
  end

  scenario "jane comments on john's comment" do 
    john_comments()
    login_as(jane)
    visit root_path
    click_on '1 Comment'
    click_on 'Reply'
    fill_in "Enter your text here...", with: 'Thanks, John!'
    find(".submit").click
    
    
    expect(page).to have_content('Thanks, John!')
    expect(jane_post.comments.count).to eq(2)
  end
end