module ApplicationHelper
	def belongs_to_user?(resource)
    resource.user == current_user
  end
  def active_class(name)
   current_page?(name) ? 'active' : ''
 	end

end
