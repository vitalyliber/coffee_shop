module CalendarsHelper

  def sum_orders orders
    sum = 0
    orders.each do |order|
      sum += order.products.sum(:price)
    end
    sum
  end

end
