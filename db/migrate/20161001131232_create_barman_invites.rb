class CreateBarmanInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :barman_invites do |t|
      t.integer :point_id
      t.string :code

      t.timestamps
    end
  end
end
