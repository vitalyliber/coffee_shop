module API
  module V1
    class Orders < Grape::API
      format :json
      helpers API::AuthHelper
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

          JSON.parse( params[:products], symbolize_names: true ).dig(:products).each do |product|

            product.dig( :repeat ).times do
              order.products << Product.find( product.dig(:id) )
            end

          end

          order.save

          point = Point.find_by(id: params[:point])
          date = Time.now
          orders = point.orders.all_day(date)

          sum_orders orders
        end

      end
    end
  end
end

