require 'rails_helper'
require 'devise'
RSpec.describe Admin::HomeController, type: :controller do
  before(:all) do
    @user = User.first
  end

  it "#index" do
    get :index
     expect(response).to have_http_status(200)
    expect(response).to render_template(:index)
  end
end
