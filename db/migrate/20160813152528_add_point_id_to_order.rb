class AddPointIdToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :point_id, :integer
  end
end
