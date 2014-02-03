class Bet < ActiveRecord::Base

	# association
	belongs_to :player
	validates :player, presence: true

	belongs_to :match
	validates :match, presence: true

	has_one :result, :as => :resultable, :autosave => true, :inverse_of => :resultable
	accepts_nested_attributes_for :result

end
