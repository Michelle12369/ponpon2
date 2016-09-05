require 'rails_helper'

RSpec.describe "items/new", type: :view do
  before(:each) do
    assign(:item, Item.new(
      :item_price => 1,
      :item_name => "MyString",
      :item_about => "MyText"
    ))
  end

  it "renders new item form" do
    render

    assert_select "form[action=?][method=?]", items_path, "post" do

      assert_select "input#item_item_price[name=?]", "item[item_price]"

      assert_select "input#item_item_name[name=?]", "item[item_name]"

      assert_select "textarea#item_item_about[name=?]", "item[item_about]"
    end
  end
end
