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
	default_scope {includes(:result).references(:result)}


	validate :one_bet_per_match_per_player

	# only one bet per match per player is allowed
	def one_bet_per_match_per_player

		logger.debug "new record ? #{self.new_record?}"
		# if it's a new bet, it's all good
		#return unless self.new_record?

		logger.debug "self --> #{self.inspect}"
		# otherwise is there already an existing bet on this match for this player
		existing_bet = Bet.where("player_id = ? AND match_id=?", self.player_id, self.match_id).take
		logger.debug "self --> #{existing_bet.inspect}"
		unless existing_bet.nil?
			errors.add(:match, "Only one bet per match is allowed")
		end
	end

end
