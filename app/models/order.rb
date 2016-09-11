class Order < ApplicationRecord
  resourcify
  validates :products, :point_id, presence: :true

  scope :all_day, ->(date) { where(created_at: date.beginning_of_day..date.to_date.end_of_day) }
  scope :current_sales, ->(date) { where(created_at: date..Time.now) }

  has_many :order_lists
  has_many :products, through: :order_lists
  belongs_to :point

  def start_time
    self.created_at
  end
end
