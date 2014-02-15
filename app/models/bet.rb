class Bet < ActiveRecord::Base

	# player association
	belongs_to :player
	validates :player, presence: true

	# match association
	belongs_to :match
	validates :match, presence: true

	# result association
	has_one :result, :as => :resultable, :autosave => true, :inverse_of => :resultable
	accepts_nested_attributes_for :result
	default_scope {includes(:result).references(:result).includes(match: [:group, :team_a, :team_b]).references(:match)}

	validate :one_bet_per_match_per_player, on: :create

	# only one bet per match per player is allowed
	def one_bet_per_match_per_player
		existing_bet = Bet.where("player_id = ? AND match_id=?", self.player_id, self.match_id).take
		unless existing_bet.nil?
			errors.add(:match, "Only one bet per match is allowed")
		end
	end

end
