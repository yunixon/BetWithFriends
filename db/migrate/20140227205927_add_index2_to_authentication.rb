class AddIndex2ToAuthentication < ActiveRecord::Migration
  def change
    #add_column :authentications, :token, :string
    add_index :authentications, :token, unique: true
  end
end
