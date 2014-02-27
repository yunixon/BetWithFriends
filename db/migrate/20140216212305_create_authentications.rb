class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :ip
      t.string :user_agent
      t.string :token
      t.integer :user_id

      t.timestamps
    end
  end
end
