class Product < ApplicationRecord
  resourcify
  validates :title, :price, :ml, presence: :true

  belongs_to :product_list
  has_many :order_lists
  has_many :orders, through: :order_lists
end
