class AddMeterToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :meter, :integer, default: 0
  end
end
