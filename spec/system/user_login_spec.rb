require "rails_helper"

RSpec.describe "user login", type: :system do
  let!(:user) { create(:user) }

  context 'when user is not logged in with valid credentials' do
    it 'does not redirect to root_path' do
      visit(root_path)

      expect(page).to have_current_path(user_session_path)

      fill_in "Email", with: user.email
      fill_in "Password", with: "123"
      click_on("Log in")

      expect(page).to have_current_path(user_session_path)

      expect(page).to have_content "Invalid Login or password."
    end
  end

  context 'when user is logged in with valid credentials' do
    it 'successfully redirects to newsfeed as root path' do
      visit(user_session_path)
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_on("Log in")

      expect(page).to have_current_path(root_path)
    end
  end

  context 'when user logs in with facebook auth' do
    before do
      mock_oauth_provider(:facebook)
    end

    after do
      OmniAuth.config.mock_auth[:facebook] = nil
    end

    it 'successfully redirects to root path' do
      visit(user_session_path)
      click_on("Sign in with Facebook")

      expect(page).to have_current_path(root_path)
    end
  end
end