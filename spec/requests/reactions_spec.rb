require 'rails_helper'

RSpec.describe "Reactions", type: :request do 

  describe "GET /create" do
    pending it "returns http success" do
      get "/reactions/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    pending it "returns http success" do
      get "/reactions/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
