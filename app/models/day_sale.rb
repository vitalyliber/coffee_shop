class DaySale < ApplicationRecord
  enum status: [:opened, :closed]

  validates :start, :point, :user, :status, presence: :true
  validate :uniqueness_day_sale

  belongs_to :point
  belongs_to :user
  has_many :orders

  private

  def uniqueness_day_sale
    if new_record? and self.class.where(status: :opened, user: user, point: point).present?
      errors.add(:status, "should be uniq")
    end
  end
end
