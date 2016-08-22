class Order < ApplicationRecord
  resourcify
  validates :products, :cost_price, :point_id, presence: :true

  has_many :order_lists
  has_many :products, through: :order_lists
  belongs_to :point

  def start_time
    self.created_at
  end
end
