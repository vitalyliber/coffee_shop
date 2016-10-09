class User < ApplicationRecord
  rolify

  after_create :install_point

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, omniauth_providers: [:vkontakte]

  has_many :day_sales
  has_one :common_tuning

  def install_point
    point = Point.create(title: 'First Point')
    self.add_role :admin, point
    CommonTuning.create(current_point: point, user: self)
    product_list = ProductList.create(point: point)
    Product.create(product_list: product_list, title: 'Coffee Cup', price: 140, ml: 400, meter: :ml)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
