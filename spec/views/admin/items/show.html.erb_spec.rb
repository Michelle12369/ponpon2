require 'rails_helper'

RSpec.describe "admin/items/show", type: :view do
  before(:each) do
    @admin_item = assign(:admin_item, Admin::Item.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
