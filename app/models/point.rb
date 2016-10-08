class Point < ApplicationRecord
  resourcify
  validates :title, presence: :true
  has_many :orders, dependent: :destroy
  has_many :day_sales, dependent: :destroy
  has_one :product_list, dependent: :destroy
  has_one :barman_invite
end
