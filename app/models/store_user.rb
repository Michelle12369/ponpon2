class StoreUser < ApplicationRecord
	belongs_to :user
	belongs_to :store
	#validates_uniqueness_of :subscriber_id, :scope => :list_id
end
