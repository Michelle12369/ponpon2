module DeviseHelper

  # Hacky way to translate devise error messages into devise flash error messages
  def devise_error_messages!
    if resource.errors.full_messages.any?
        #flash.now[:error] = resource.errors.full_messages.join(' & ')
        flash[:error] = resource.errors.full_messages.first
    end
    return ''
  end
  def city_array
  	["台北市","基隆市","新北市","桃園市","新竹市","新竹縣","苗栗縣","台中市","彰化縣","南投縣","雲林縣","嘉義市","嘉義縣","台南市","高雄市","屏東縣","台東縣","花蓮縣","宜蘭縣","澎湖縣","金門縣","連江縣"]
  
  end
end