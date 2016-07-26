class Coupon < ActiveRecord::Base
  #has_many :users,:through=>:coupon_users
  #has_many :coupon_users
  belongs_to :user
  has_closure_tree
  #File.open("example.dot", "w") { |f| f.write(Coupon.root.to_dot_digraph) }
  
  def self.copy_coupon(receiver_id,coupon)
    if receiver_id!=coupon.user_id 
      coupon.children.new(user:User.find(receiver_id),
                          coupon_title:coupon.coupon_title,
                          expiry_date: coupon.expiry_date,
                          item: coupon.item,
                          start_date: coupon.start_date,
                          discount_type: coupon.discount_type,
                          discount_ceiling_people: coupon.discount_ceiling_people,
                          discount_ceiling_amount: coupon.discount_ceiling_amount,
                          condition_type: coupon.condition_type,
                          condition_content: coupon.condition_content,
                          other_content: coupon.other_content,
                          used: false,
                          discount:coupon.discount,
                          computed_discount:coupon.discount
                          )
    end
  end
  
def to_digraph_label
     user.name+":"+id.to_s+":"+computed_discount.to_s
end


#{19=>0,18=>1}

  def self.calculate_discount(coupon_id,position)
    now_coupon=Coupon.find(coupon_id)
    puts now_coupon.computed_discount
    puts now_coupon.discount*0.5
    now_discount=now_coupon.computed_discount+now_coupon.discount*(0.5**position)
    now_coupon.update(computed_discount: now_discount)
  end 


end
#Coupon.create(expiry_date: "2016/8/22", discount: 0.05, coupon_title: "爺爺蛋包飯",
#user_id: 1, item: "G排", start_date: "2016/7/22", discount_type: 2, 
#discount_ceiling_people: 8, discount_ceiling_amount: 0.4, condition_type: 2,
#condition_content: nil, other_content: "先來電預約", used: false, computed_discount:0.05)