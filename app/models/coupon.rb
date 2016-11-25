class Coupon < ActiveRecord::Base
  belongs_to :user
  belongs_to :store
  has_closure_tree
  validates_presence_of :item,:start_date,:expiry_date,:computed_discount,:admin_coupon_limit,:coupon_title#,:coupon_pic

  before_save :default_values
  def default_values
    self.distributed_number ||= 0
  end


  #coupon qrcode
  mount_uploader :qr_code, AvatarUploader
  

  #coupon照片+裁切
  mount_uploader :coupon_pic, CropUploader
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_coupon_pic

  def crop_coupon_pic
    coupon_pic.recreate_versions! if crop_x.present?
  end


  #使用者之間發送優惠卷時複製一張給自己的下線
  def self.copy_coupon(receiver_id,coupon)
    if receiver_id!=coupon.user_id 
      coupon.update(distributed_number: coupon.distributed_number+=1)
      coupon.children.create(user:User.find(receiver_id),
                          coupon_title:coupon.coupon_title,
                          expiry_date: coupon.expiry_date,
                          item: coupon.item,
                          start_date: coupon.start_date,
                          discount_ceiling_people: coupon.discount_ceiling_people,
                          discount_ceiling_amount: coupon.discount_ceiling_amount,
                          other_content: coupon.other_content,
                          used: false,
                          discount:coupon.discount,
                          computed_discount:coupon.root.computed_discount,
                          store_id:coupon.store_id,
                          admin_coupon_limit:coupon.admin_coupon_limit
                          )
      
    end
  end
  
  require 'rqrcode'
  require 'rqrcode_png'
  
  def self.qrcode(receiver_id,new_coupon)
    url="http://www.liveqoupon.com/admin/stores/#{new_coupon.store.id}/coupons/#{new_coupon.id}/confirm"
    @qrcode = RQRCode::QRCode.new(url,:size => 4, :level => :l)#用真的網址line才掃得到
    tmp_path = Rails.root.join("#{new_coupon.store.store_name}_#{new_coupon.id}.png")
    png = @qrcode.to_img.resize(150, 150).save(tmp_path)
    # Stream is handed closed, we need to reopen it
    File.open(png.path) do |file|
      new_coupon.update(qr_code:file)
    end
    File.delete(png.path)
  end


  #有人消費後計算折數
  #{19=>0,18=>1}
  def self.calculate_discount(coupon_id,position)
    now_coupon=Coupon.find(coupon_id)
    if now_coupon.root?||now_coupon.used==true||now_coupon.expiry_date<=Date.today||now_coupon.computed_discount<=now_coupon.discount_ceiling_amount#若coupon是root或是已使用或是已過期就不更新或是折數已達上限

    else 
      puts now_coupon.computed_discount
      puts now_coupon.discount*0.5
      now_discount=now_coupon.computed_discount-now_coupon.discount*(0.5**position)
      puts "安安"+now_discount.to_s
      now_coupon.update(computed_discount: now_discount)
    end
  end 


  def to_digraph_label
     user.name+":"+id.to_s+":"+computed_discount.to_s
  end

end
#Coupon.create(expiry_date: "2016/8/22", discount: 0.05, coupon_title: "爺爺蛋包飯",
#user_id: 1, item: "G排", start_date: "2016/7/22", discount_type: 2, 
#discount_ceiling_people: 6, discount_ceiling_amount: 0.7, condition_type: 2,
#condition_content: nil, other_content: "先來電預約", used: false, computed_discount:0.9)