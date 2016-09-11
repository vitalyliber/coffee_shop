class Product < ApplicationRecord
  resourcify
  validates :title, :price, :ml, :meter, presence: :true

  belongs_to :product_list

  enum meter: [:ml, :piece]
end
