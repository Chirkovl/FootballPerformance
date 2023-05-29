class CreateMatchTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :match_teams do |t|
      t.references :match, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.timestamps
    end
  end
end
