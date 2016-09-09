module API
  class Root < Grape::API
    prefix    'api'
    format    :json

    helpers do
      def sum_orders orders
        sum = 0
        orders.each do |order|
          sum += order.products.sum(:price)
        end
        sum
      end
    end

    namespace 'v1'do
      mount API::V1::Root
    end

    add_swagger_documentation api_version: "v1", mount_path: "/"

  end
end

