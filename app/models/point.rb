class Point < ApplicationRecord
  resourcify
  validates :title, presence: :true
  has_many :orders
  has_many :day_sales
  has_one :product_list
end
