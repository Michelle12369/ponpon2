module ApplicationHelper
	def belongs_to_user?(resource)
    resource.user == current_user
  end

  def belongs_to_store?(resource)
    resource.store == @current_store
  end

  def name_store_or_user?(resource,role)
    if role.nil?
      link_to resource.store.store_name, store_path(resource.store)
    else
      link_to resource.user.name, user_path(resource.user)
    end
  end

  def pic_store_or_user?(resource,role)
    if role.nil?
      render 'shared/store_cover_photo', store: resource.store
    else
      render 'shared/avatar', user: resource.user 
    end
  end

  def active_class(name)
   current_page?(name) ? 'active' : ''
  end

  def active_admin_class(name,name2)
    if(current_page?(name)||current_page?(name2))
      "active"
    end  
    
  end

  def is_admin?
  	if current_user.admin?
  		link_to '切換為店家', admin_home_path,class: "nav-link"
    else
      link_to '申請成為店家', admin_front_path,class: "nav-link"
  	end
  end
  
  def city_array
    ["台北市","基隆市","新北市","桃園市","新竹市","新竹縣","苗栗縣","台中市","彰化縣","南投縣","雲林縣","嘉義市","嘉義縣","台南市","高雄市","屏東縣","台東縣","花蓮縣","宜蘭縣","澎湖縣","金門縣","連江縣"]
  end

  def store_type_array
    ["中式","港式","日式","韓式","美式","義式","泰式","小吃","熱炒","咖啡輕食","甜點冰飲","下午茶","西式/牛排","早午餐","素蔬食","鐵板燒","燒烤","火鍋","飯店","吃到飽"]
  end  
  
end
