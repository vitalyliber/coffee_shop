class Order < ApplicationRecord
  resourcify
  validates :point_id, presence: :true

  scope :all_day, ->(date) { where(created_at: date.beginning_of_day..date.to_date.end_of_day) }
  scope :current_sales, ->(date) { where(created_at: date..Time.now) }

  belongs_to :point
  belongs_to :day_sale

  def start_time
    self.created_at
  end
end
