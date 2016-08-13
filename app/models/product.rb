class Product < ApplicationRecord
  resourcify
  has_many :order_lists
  has_many :orders, through: :order_lists
end
