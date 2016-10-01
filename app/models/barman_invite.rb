class BarmanInvite < ApplicationRecord
  validates :point, presence: :true

  belongs_to :point

  def generate_code
    self.code = loop do
      random_code = SecureRandom.hex(20)
      break random_code unless self.class.exists?(code: random_code)
    end
  end
end
