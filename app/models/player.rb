require 'digest/sha1'

class Player < ActiveRecord::Base

	belongs_to :crew
	default_scope {includes(:crew).references(:crew)}
	#scope :authenticating, -> {includes(:authentication).references(:authentication)}

	has_many :bet, inverse_of: :player
	has_one :authentication, inverse_of: :player

	validates :name, presence: true
	validates :email_address, presence: true, uniqueness: true
	validates :password, confirmation: true
	validate :validates_password

	before_save :handle_password


	# password is required for creation and optional for updating
	def validates_password
		if self.new_record?
			if password.blank?
				errors.add(:password, "is required")
			end
		end
	end


	# if the new password is blank, the old value is unchanged, otherwise, the new password is hashed
	def handle_password
		if self.password.blank?
			self.password = self.password_was
		else 
			self.password = hash_password self 
		end
	end

	# hash the password
	def hash_password(user)
		return Digest::SHA1.base64digest user.password + "|+|" + user.email_address
	end

end
