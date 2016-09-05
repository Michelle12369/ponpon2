require 'rails_helper'

RSpec.describe "items/edit", type: :view do
  before(:each) do
    @item = assign(:item, Item.create!(
      :item_price => 1,
      :item_name => "MyString",
      :item_about => "MyText"
    ))
  end

  it "renders the edit item form" do
    render

    assert_select "form[action=?][method=?]", item_path(@item), "post" do

      assert_select "input#item_item_price[name=?]", "item[item_price]"

      assert_select "input#item_item_name[name=?]", "item[item_name]"

      assert_select "textarea#item_item_about[name=?]", "item[item_about]"
    end
  end
end
