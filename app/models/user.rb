require 'digest/sha1'

class User < ActiveRecord::Base

	belongs_to :crew
	default_scope {includes(:crew).references(:crew)}

	has_many :bet, inverse_of: :user

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
			self.password = hash_password self.email_address, self.password 
		end
	end

	# hash the password
	def hash_password(email_address, password)
		return Digest::SHA1.base64digest password + "|o|" + email_address
	end

	# return true if the given password is the right one
	def authenticate(given_password)
		hashed_password = hash_password self.email_address, given_password
		return hashed_password == self.password
	end

	# serialize the user so that only important data are kept
	def serialize
		self.password = ""
		return self
	end
end
