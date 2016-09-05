json.extract! item, :id, :item_price, :item_name, :item_about, :created_at, :updated_at
json.url item_url(item, format: :json)