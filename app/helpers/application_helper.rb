module ApplicationHelper
	def belongs_to_user?(resource)
    resource.user == current_user
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
