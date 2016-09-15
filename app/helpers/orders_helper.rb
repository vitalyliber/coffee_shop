module OrdersHelper

  def sum_orders orders
    sum = 0
    orders.each do |order|
      sum += JSON.parse( order.raw_code, symbolize_names: true ).dig(:price)
    end
    sum
  end

end
