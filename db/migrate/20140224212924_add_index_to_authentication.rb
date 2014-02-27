class AddIndexToAuthentication < ActiveRecord::Migration
  def change
    add_index :authentications, :player_id, unique: true
  end
end
