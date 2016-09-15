class AddDaySalesIdToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :day_sale_id, :integer
  end
end
