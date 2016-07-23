class CreateOrderLists < ActiveRecord::Migration[5.0]
  def change
    create_table :order_lists do |t|
      t.integer :order_id
      t.integer :product_id

      t.timestamps
    end
  end
end
