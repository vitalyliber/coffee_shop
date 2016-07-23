class Order < ApplicationRecord
  has_many :order_lists
  has_many :products, through: :order_lists
end
