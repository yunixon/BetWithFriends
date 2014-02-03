class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :score_team_a
      t.integer :score_team_b
      t.string :resultable_type
      t.integer :resultable_id

      t.timestamps
    end
  end
end
