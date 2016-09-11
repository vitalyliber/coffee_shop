class RenameCostPriceInOrders < ActiveRecord::Migration[5.0]
  def change
    rename_column :orders, :cost_price, :raw_code
    change_column :orders, :raw_code, :text
  end
end
