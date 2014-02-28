class Bet < ActiveRecord::Base

	# user association
	belongs_to :user
	validates :user, presence: true

	# match association
	belongs_to :match
	validates :match, presence: true

	# result association
	has_one :result, :as => :resultable, :autosave => true, :inverse_of => :resultable
	accepts_nested_attributes_for :result
	default_scope {includes(:result).references(:result).includes(match: [:group, :team_a, :team_b]).references(:match)}

	validate :one_bet_per_match_per_user, on: :create

	# only one bet per match per user is allowed
	def one_bet_per_match_per_user
		existing_bet = Bet.where("user_id = ? AND match_id=?", self.user_id, self.match_id).take
		unless existing_bet.nil?
			errors.add(:match, "Only one bet per match is allowed")
		end
	end

end
