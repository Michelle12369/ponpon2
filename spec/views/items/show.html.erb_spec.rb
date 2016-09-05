require 'rails_helper'

RSpec.describe "items/show", type: :view do
  before(:each) do
    @item = assign(:item, Item.create!(
      :item_price => 2,
      :item_name => "Item Name",
      :item_about => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Item Name/)
    expect(rendered).to match(/MyText/)
  end
end
