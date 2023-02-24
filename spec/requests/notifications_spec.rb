require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  describe "GET /destroy" do
    pending it "returns http success" do
      get "/notifications/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
