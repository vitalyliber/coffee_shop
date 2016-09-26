class CreateCommonTunings < ActiveRecord::Migration[5.0]
  def change
    create_table :common_tunings do |t|
      t.integer :current_point_id
      t.integer :user_id

      t.timestamps
    end
  end
end
