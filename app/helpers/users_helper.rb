module UsersHelper


  def is_current_user?(user)
    user == current_user
  end

  def show_post(activities,user)
  	if activities.empty?&&is_current_user?(user)
  		render "shared/initial_post"
  	elsif activities.empty?
  		render('shared/no_resource', resources: '貼文')
  	else
  		render_activities(activities, layout: '/shared/activity')
  	end
  end
end