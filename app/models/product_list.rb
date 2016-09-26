class ProductList < ApplicationRecord
  has_many :products, dependent: :destroy
  belongs_to :point
end
