module API
  module V1
    class Orders < Grape::API
      format :json
      helpers API::AuthHelper
      helpers OrdersHelper
      include API::Defaults

      before do
        authenticate!
      end
      resource :orders do

        desc 'Create Order',
             is_array: true,
             http_codes: [
                 { code: 422, message: 'OrderOutError', model: Entities::Product }
             ]

        params do
          requires :products, type: String, desc: 'List of products with their repeats', default: "{\"products\":[{\"id\":6,\"repeat\":3},{\"id\":7,\"repeat\":1}]}"
          requires :point, type: String, desc: 'Identifier Point', default: ""
        end

        post do

          order = Order.new( point_id: params[:point] )

          raw_code = {
              products: [],
              price: 0
          }

          JSON.parse( params[:products], symbolize_names: true ).dig(:products).each do |p|
            product = Product.find( p.dig(:id) )
            raw_code[:products] << {
              id: product.id,
              title: product.title,
              price: product.price,
              meter: product.meter,
              ml: product.ml,
              repeat: p.dig(:repeat)
            }
          end

          raw_code.dig(:products).each do |product|
            product.dig(:repeat).times do
              raw_code[:price] += product[:price]
            end
          end

          order.raw_code = raw_code.to_json
          order.save

          point = Point.find_by(id: params[:point])
          sales_day = point.day_sales.find_by(status: :opened, user: current_user)
          orders = point.orders.current_sales(sales_day.start)

          sum_orders orders
        end

      end
    end
  end
end

