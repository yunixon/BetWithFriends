class RenameUserIdInAuthentication < ActiveRecord::Migration


	def self.up
		rename_column :authentications, :user_id, :player_id
	end

	def self.down
		rename_column :authentications, :player_id, :user_id
	end

end
