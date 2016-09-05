class Admin::Search < ActiveRecord::Base
  self.table_name ="admin_searches"
	def search_users(store,coupon)
		if location.present? && gender.present? && max_age.present? && min_age.present?
			users=User.where("location = ? and gender = ? and age <= ? and age >= ?",location,gender,max_age,min_age)
		
		elsif location.present? && gender.present? && max_age.present?
			users=User.where("location = ? and gender = ? and age <= ?",location,gender,max_age)
		
		elsif location.present? && gender.present? &&  min_age.present?
			users=User.where("location = ? and gender = ? and age >= ?",location,gender,min_age)
		
		elsif gender.present? && max_age.present? && min_age.present?
			users=User.where("gender = ? and age <= ? and age >= ?",gender,max_age,min_age)
		
		elsif location.present? && gender.present? 
			users=User.where("location = ? and gender = ?",location,gender)

		elsif gender.present? && max_age.present?
			users=User.where("gender = ? and age <= ?",gender,max_age)	

		elsif gender.present? && min_age.present?
			users=User.where("gender = ? and age >= ?",gender,min_age)
		else
			users=User.where("gender = ? ",gender)
		end

		have_coupon_user=User.joins(:coupons).where(coupons: {id:coupon.descendant_ids,used: false })


		if relation==0	
			users1=store.followers-have_coupon_user
		elsif relation ==1
			users1=User.all-store.followers-have_coupon_user	
		else 
			users1=User.all.to_a-have_coupon_user	
		end

			
		return users.merge(users1)
	end
end
