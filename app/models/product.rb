class Product < ApplicationRecord
  has_many :order_lists
  has_many :orders, through: :order_lists
end
