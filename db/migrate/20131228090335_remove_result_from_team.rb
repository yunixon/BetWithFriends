class RemoveResultFromTeam < ActiveRecord::Migration
  def change
    remove_column :teams, :result, :string
  end
end
