class Standing < ActiveRecord::Base

	# associations
	belongs_to :team
	default_scope {includes(:team).references(:team)}
	validates :team, presence: true

	belongs_to :group
	validates :group, presence: true


	# validation
	validates :played, :won, :draw, :lost, :goals_for, :goals_against, :points, numericality: { greater_than_or_equal_to: 0 }
end
