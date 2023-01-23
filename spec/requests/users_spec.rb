require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:example) { create(:user, :faker) }

  before do
    login_as(example)
  end 

  describe "GET /index" do
    it "returns http success" do
      get "/users"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/users/#{example.id}"
      expect(response).to have_http_status(:success)
    end
  end

end
