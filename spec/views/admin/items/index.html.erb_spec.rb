require 'rails_helper'

RSpec.describe "admin/items/index", type: :view do
  before(:each) do
    assign(:admin_items, [
      Admin::Item.create!(),
      Admin::Item.create!()
    ])
  end

  it "renders a list of admin/items" do
    render
  end
end
