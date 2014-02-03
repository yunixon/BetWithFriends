class AddTeamAIdFromMatch < ActiveRecord::Migration
  def change
    add_column :matches, :team_a_id, :integer
  end
end
