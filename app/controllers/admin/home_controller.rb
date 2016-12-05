class Admin::HomeController <Admin::BaseController
	def index
		@users=User.all.order(created_at: :desc)
	end

	def operating_data
		@admin_coupons = @current_store.coupons.roots.order(created_at: :desc)
		discount=0
		count=0
		consumer_male=0
		consumer_female=0
		sender_male=0
		sender_female=0
		@discount_arr=[]
		@ages_sender=[0,0,0,0,0,0,0,0]
		@ages_consumer=[0,0,0,0,0,0,0,0]
		@admin_coupons.each do |coupon|
			#coupon_sender
			sender_all=coupon.descendants-coupon.children
			sender_all.each do |sender|
				if sender.user.present?
					if sender.user.gender=='male'
						sender_male+=1
					else
						sender_female+=1
					end
					user_age=sender.user.age
					if user_age<18
	              		@ages_sender[0]+=1
	            	elsif user_age<25
	              		@ages_sender[1]+=1
	            	elsif user_age<33
	              		@ages_sender[2]+=1
	            	elsif user_age<41
	              		@ages_sender[3]+=1
	            	elsif user_age<49
	              		@ages_sender[4]+=1
	            	elsif user_age<56
	              		@ages_sender[5]+=1
	            	elsif user_age<60
	              		@ages_sender[6]+=1
	            	else
	              		@ages_sender[7]+=1
	            	end
	            end
			end

			coupon.descendants.where("used=?",true).each do |des_coupon|
				discount+=des_coupon.computed_discount
				count+=1
				#coupon_consumer
				if des_coupon.user.present?
					if des_coupon.user.gender=='male'
						consumer_male+=1
					else
						consumer_female+=1
					end
					user_age=des_coupon.user.age
					if user_age<18
	              		@ages_consumer[0]+=1
	            	elsif user_age<25
	              		@ages_consumer[1]+=1
	            	elsif user_age<33
	              		@ages_consumer[2]+=1
	            	elsif user_age<41
	              		@ages_consumer[3]+=1
	            	elsif user_age<49
	              		@ages_consumer[4]+=1
	            	elsif user_age<56
	              		@ages_consumer[5]+=1
	            	elsif user_age<60
	              		@ages_consumer[6]+=1
	            	else
	              		@ages_consumer[7]+=1
	            	end
            	end
			end
			count =1 if count==0
			@discount_arr<<((discount/count)*10).round(2)
			discount=0
			count=0
		end
		@test=Hash[@admin_coupons.zip(@discount_arr)]
		@genderxaxis=["男性","女性"]
		@gender_sender=[sender_male,sender_female]
		@gender_consumer=[consumer_male,consumer_female]
		@agexaxis=["18歲以下","18~24歲","25~32歲","33~40歲","41~48歲","49~55歲","56~60歲","60歲以上"]

	end
end
