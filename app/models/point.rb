class Point < ApplicationRecord
  resourcify
  validates :title, presence: :true
  has_many :orders
end
