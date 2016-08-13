class AddMlToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :ml, :integer
  end
end
