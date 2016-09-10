module API
  module V1
    module Entities
      class Product < Grape::Entity
        expose :id
        expose :title
        expose :price
        expose :ml
        expose :meter
      end
    end
  end
end