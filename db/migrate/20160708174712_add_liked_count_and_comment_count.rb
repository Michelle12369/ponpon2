class AddLikedCountAndCommentCount < ActiveRecord::Migration
  def change
  	add_column :posts, :cached_votes_up, :integer, :default => 0
  	add_index  :posts, :cached_votes_up
  	add_column :posts, :comments_count, :integer, :default => 0
    add_index  :posts, :comments_count
  end
end
