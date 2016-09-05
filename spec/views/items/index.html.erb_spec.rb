require 'rails_helper'

RSpec.describe "items/index", type: :view do
  before(:each) do
    assign(:items, [
      Item.create!(
        :item_price => 2,
        :item_name => "Item Name",
        :item_about => "MyText"
      ),
      Item.create!(
        :item_price => 2,
        :item_name => "Item Name",
        :item_about => "MyText"
      )
    ])
  end

  it "renders a list of items" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Item Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
