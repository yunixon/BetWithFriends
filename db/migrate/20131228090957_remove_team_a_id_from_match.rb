class RemoveTeamAIdFromMatch < ActiveRecord::Migration
  def change
    remove_column :matches, :team_a_id, :integer
  end
end
