class Product < ApplicationRecord
  resourcify
  validates :title, :price, :ml

  has_many :order_lists
  has_many :orders, through: :order_lists
end
