require 'rails_helper'

RSpec.describe "admin/posts/index", type: :view do
  before(:each) do
    assign(:admin_posts, [
      Admin::Post.create!(),
      Admin::Post.create!()
    ])
  end

  it "renders a list of admin/posts" do
    render
  end
end
