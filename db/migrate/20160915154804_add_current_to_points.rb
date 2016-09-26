class AddCurrentToPoints < ActiveRecord::Migration[5.0]
  def change
    add_column :points, :current, :boolean, default: false
  end
end
