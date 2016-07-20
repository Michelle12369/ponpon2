class AddCountToPost < ActiveRecord::Migration
  def change
  	Post.pluck(:id).each do |i|
      Post.reset_counters(i, :comments) # 全部重算一次
    end
  end
end
