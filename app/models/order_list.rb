class OrderList < ApplicationRecord
  validates :order, :product, presence: :true
  belongs_to :order
  belongs_to :product
end
