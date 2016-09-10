class ProductList < ApplicationRecord
  has_many :products
  belongs_to :point
end
