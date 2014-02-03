class Result < ActiveRecord::Base
	belongs_to :resultable, :polymorphic => true
	validates :resultable, presence: true

	TYPE_MATCH = "Match".freeze
	TYPE_BET = "Bet".freeze

	validates :score_team_a, :score_team_b, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
	
end
