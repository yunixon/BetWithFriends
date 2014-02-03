class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.timestamp :date_time
      t.integer :match_id
      t.integer :player_id

      t.timestamps
    end
  end
end
