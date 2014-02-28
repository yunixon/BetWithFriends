class Crew < ActiveRecord::Base
	has_many :users
	validates :name, presence: true, uniqueness: true
end
