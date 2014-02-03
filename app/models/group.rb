class Group < ActiveRecord::Base

	# associations
	belongs_to :stage
	validates :stage, presence: true

	has_many :matches, dependent: :destroy
	has_many :standings, dependent: :destroy, inverse_of: :group

	# validation
	validates :name, presence: true, uniqueness: true

end
