class RemoveOrderList < ActiveRecord::Migration[5.0]
  def change
    drop_table :order_lists
  end
end
