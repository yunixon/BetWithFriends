class RemoveTeamBIdFromTeam < ActiveRecord::Migration
  def change
    remove_column :teams, :team_b_id, :integer
  end
end
