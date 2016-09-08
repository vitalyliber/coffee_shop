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
        get do
          products = Product.all

          present :products, products, with: Entities::Product
        end

      end
    end
  end
end

