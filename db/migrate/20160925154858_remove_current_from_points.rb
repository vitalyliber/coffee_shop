class RemoveCurrentFromPoints < ActiveRecord::Migration[5.0]
  def change
    remove_column :points, :current
  end
end
