class CreateDaySales < ActiveRecord::Migration[5.0]
  def change
    create_table :day_sales do |t|
      t.datetime :start
      t.datetime :end
      t.integer :point_id
      t.integer :user_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
