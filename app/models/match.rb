class Match < ActiveRecord::Base

	#associations
	belongs_to :group
	validates :group, presence: true

	belongs_to :team_a, class_name: "Team"
	belongs_to :team_b, class_name: "Team"
	validates :team_a, presence: true
	validates :team_b, presence: true

	has_one :result, :as => :resultable, :autosave => false
	has_many :bet, inverse_of: :match

	default_scope {includes(:team_a).references(:team_a).includes(:team_b).references(:team_b).includes(:group).references(:group).includes(:result).references(:result)}

	# validation
	validates :date, presence: true
	validate :teams_must_be_different


	# teams must be different
	def teams_must_be_different
		if team_a_id == team_b_id
			errors.add(:team_b, "a match needs 2 different teams")
		end
	end

	# to string
	def to_string
    "#{group.name} - #{team_a.name} vs #{team_b.name} on #{date}"
  end
end
