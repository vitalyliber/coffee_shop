class CommonTuning < ApplicationRecord
  validates :user, uniqueness: :true
  belongs_to :current_point, class_name: 'Point', foreign_key: 'current_point_id'
  belongs_to :user
end
