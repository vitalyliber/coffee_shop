class User < ApplicationRecord
  rolify

  after_create :install_point

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  has_many :day_sales

  def install_point
    point = Point.create(title: 'First Point', current: true)
    self.add_role :admin, point
    product_list = ProductList.create(point: point)
    Product.create(product_list: product_list, title: 'Coffee Cup', price: 140, ml: 400, meter: :ml)
  end
end
