require 'rails_helper'

RSpec.describe "admin/posts/edit", type: :view do
  before(:each) do
    @admin_post = assign(:admin_post, Admin::Post.create!())
  end

  it "renders the edit admin_post form" do
    render

    assert_select "form[action=?][method=?]", admin_post_path(@admin_post), "post" do
    end
  end
end
