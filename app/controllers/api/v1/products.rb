module API
  module V1
    class Products < Grape::API
      format :json
      helpers API::AuthHelper
      include API::Defaults

      before do
        authenticate!
      end
      resource :products do

        desc 'Return list of products',
             is_array: true,
             http_codes: [
                 { code: 200, message: 'get Products', model: Entities::Product },
                 { code: 422, message: 'ProductsOutError', model: Entities::Product }
             ]

        params do
          requires :point, type: String, desc: 'Identifier Point', default: ""
        end

        get do
          point = Point.find_by(id: params[:point])

          error! "Product list not exist for point: #{params[:point]}", 400 if point.blank?

          products = point.product_list.products.order(title: :asc)

          present :products, products, with: Entities::Product
        end

      end
    end
  end
end

