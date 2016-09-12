module ApplicationHelper
	def belongs_to_user?(resource)
    resource.user == current_user
  end

  def belongs_to_store?(resource)
    resource.store == @current_store
  end

  def name_store_or_user?(resource,role)
    if role.nil?
      link_to resource.store.store_name, stores_path(resource.store)
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
  
end
