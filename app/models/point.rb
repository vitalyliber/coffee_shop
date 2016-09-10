class Point < ApplicationRecord
  resourcify
  validates :title, presence: :true
  has_many :orders
  has_many :product_lists
end
