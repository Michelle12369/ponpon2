require 'rails_helper'

RSpec.describe "admin/items/new", type: :view do
  before(:each) do
    assign(:admin_item, Admin::Item.new())
  end

  it "renders new admin_item form" do
    render

    assert_select "form[action=?][method=?]", admin_items_path, "post" do
    end
  end
end
