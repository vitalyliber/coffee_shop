class Point < ApplicationRecord
  validates :title, presence: :true
  has_many :orders
end
