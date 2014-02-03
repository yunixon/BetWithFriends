class RemoveTeamAIdFromTeam < ActiveRecord::Migration
  def change
    remove_column :teams, :team_a_id, :integer
  end
end
