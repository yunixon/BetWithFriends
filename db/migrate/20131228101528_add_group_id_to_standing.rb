class AddGroupIdToStanding < ActiveRecord::Migration
  def change
    add_column :standings, :group_id, :integer
  end
end
