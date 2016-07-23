json.extract! order, :id, :title, :cost_price, :created_at, :updated_at
json.url order_url(order, format: :json)