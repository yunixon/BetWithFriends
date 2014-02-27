class Authentication < ActiveRecord::Base

	belongs_to :player
	attr_accessor :email_address, :password

	default_scope {includes(:player).references(:player)}

	# validates the form
	validates :email_address, presence: true
	validates :password, presence: true

end
