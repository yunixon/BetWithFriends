class Team < ActiveRecord::Base

	# associations
	has_many :matches, foreign_key: "team_a_id", inverse_of: :team_a
	has_many :matches, foreign_key: "team_b_id", inverse_of: :team_b

	has_many :standing, dependent: :destroy, inverse_of: :team

	#	validation
	validates :name, presence: true, uniqueness: true
end
