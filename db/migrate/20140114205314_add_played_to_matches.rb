class AddPlayedToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :played, :boolean
  end
end
