require 'rails_helper'

RSpec.describe "Admin::Items", type: :request do
  describe "GET /admin_items" do
    it "works! (now write some real specs)" do
      get admin_items_path
      expect(response).to have_http_status(200)
    end
  end
end
