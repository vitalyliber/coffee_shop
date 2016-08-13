class CreatePoints < ActiveRecord::Migration[5.0]
  def change
    create_table :points do |t|
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
