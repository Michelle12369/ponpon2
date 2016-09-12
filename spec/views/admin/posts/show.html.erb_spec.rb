require 'rails_helper'

RSpec.describe "admin/posts/show", type: :view do
  before(:each) do
    @admin_post = assign(:admin_post, Admin::Post.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
