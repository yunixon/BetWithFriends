class AddPlayedToResults < ActiveRecord::Migration
  def change
    add_column :results, :played, :boolean
  end
end
