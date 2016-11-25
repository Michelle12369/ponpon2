class Item < ApplicationRecord
	belongs_to :store
	validates_presence_of :item_price,:item_name,:item_type,:message=>'不能為空白'
end
