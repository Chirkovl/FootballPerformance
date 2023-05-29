class CreatePerformances < ActiveRecord::Migration[7.0]
  def change
    create_table :performances do |t|
      t.references :player, foreign_key: true
      t.references :match, foreign_key: true
      t.string :performance
      t.timestamps
    end
  end
end
