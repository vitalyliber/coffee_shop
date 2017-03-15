class BarmanInvite < ApplicationRecord
  validates :point, :code, presence: :true
  before_validation :generate_code

  belongs_to :point

  def generate_code
    self.code = loop do
      random_code = SecureRandom.hex(4)
      break random_code unless self.class.exists?(code: random_code)
    end
  end
end
