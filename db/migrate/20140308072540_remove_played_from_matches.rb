class RemovePlayedFromMatches < ActiveRecord::Migration
  def change
    remove_column :matches, :played, :boolean
  end
end
