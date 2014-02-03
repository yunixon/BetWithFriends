class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.datetime :date
      t.string :result
      t.integer :team_a_id
      t.integer :team_b_id
      t.integer :group_id

      t.timestamps
    end
  end
end
