class Order < ApplicationRecord
  resourcify
  has_many :order_lists
  has_many :products, through: :order_lists

  def start_time
    self.created_at
  end
end
