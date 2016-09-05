require 'rails_helper'

RSpec.describe "admin/items/edit", type: :view do
  before(:each) do
    @admin_item = assign(:admin_item, Admin::Item.create!())
  end

  it "renders the edit admin_item form" do
    render

    assert_select "form[action=?][method=?]", admin_item_path(@admin_item), "post" do
    end
  end
end
