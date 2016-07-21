class Coupon < ActiveRecord::Base
  #has_many :users,:through=>:coupon_users
  #has_many :coupon_users
  belongs_to :user
  has_closure_tree
  
  
  def self.copy_coupon(receiver_id,coupon_id)
    if receiver_id!=self.find(coupon_id).user_id
      self.find(coupon_id).children.create(user:User.find(receiver_id),
                                           coupon_title:self.find(coupon_id).coupon_title)
    end
  end
  
  def self.update_number_of_user(coupon_id)
    now_coupon=self.find(coupon_id)
    now_coupon.update(coupon_numbers_of_user: now_coupon.descendant_ids.size)
    
  end  
end
