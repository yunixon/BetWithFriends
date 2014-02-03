class RemoveGroupIdFromTeam < ActiveRecord::Migration
  def change
    remove_column :teams, :group_id, :integer
  end
end
