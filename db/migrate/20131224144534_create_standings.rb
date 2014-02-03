class CreateStandings < ActiveRecord::Migration
  def change
    create_table :standings do |t|
      t.integer :played
      t.integer :won
      t.integer :draw
      t.integer :lost
      t.integer :goals_for
      t.integer :goals_against
      t.integer :points
      t.integer :team_id

      t.timestamps
    end
  end
end
