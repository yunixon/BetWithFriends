class Stage < ActiveRecord::Base
	has_many :groups, dependent: :destroy
	validates :name, presence: true, uniqueness: true
end
