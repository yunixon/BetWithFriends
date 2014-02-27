class Renameemail_addressInPlayer < ActiveRecord::Migration

	def self.up
		rename_column :players, :emailAddress, :email_address
	end

	def self.down
		rename_column :players, :email_address, :emailAddress
	end

end
