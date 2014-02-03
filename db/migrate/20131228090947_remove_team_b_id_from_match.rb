class RemoveTeamBIdFromMatch < ActiveRecord::Migration
  def change
    remove_column :matches, :team_b_id, :integer
  end
end
