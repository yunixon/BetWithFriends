class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :email_address
      t.string :password
      t.integer :crew_id

      t.timestamps
    end
  end
end
