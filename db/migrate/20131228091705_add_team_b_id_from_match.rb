class AddTeamBIdFromMatch < ActiveRecord::Migration
  def change
    add_column :matches, :team_b_id, :integer
  end
end
