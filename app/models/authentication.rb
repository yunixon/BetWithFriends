class Authentication < ActiveRecord::Base

	belongs_to :user
	attr_accessor :email_address, :password

	default_scope {includes(:user).references(:user)}

	# validates the form
	validates :email_address, presence: true
	validates :password, presence: true

end
