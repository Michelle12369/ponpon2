require 'json'

json_str = File.read(ENV["CRED_FILE"])
cloudinary_url = JSON.parse(json_str)["CLOUDINARY"]["CLOUDINARY_URL"]
Cloudinary.config_from_url(cloudinary_url)
