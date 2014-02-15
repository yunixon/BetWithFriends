require 'digest/sha1'

class Player < ActiveRecord::Base

	belongs_to :crew
	default_scope {includes(:crew).references(:crew)}

	has_many :bet, inverse_of: :player

	validates :name, presence: true
	validates :emailAddress, presence: true, uniqueness: true
	validates :password, confirmation: true
	validate :validates_password

	before_save :handle_password


	# password is required for creation and optional for updating
	def validates_password
		logger.debug "old password '#{self.password_was}'"
		logger.debug "password => #{self.inspect}"
		if self.new_record?
			if password.blank?
				errors.add(:password, "is required")
			end
		end
	end


	# if the new password is blank, the old value is unchanged, otherwise, the new password is hashed
  def handle_password
  	if self.password.blank?
  		logger.debug "password not changed"
  		self.password = self.password_was
  	else 
  		logger.debug "password is not blank, let's hash it"
    	self.password = Digest::SHA1.base64digest self.password + "|+|" + self.emailAddress
  	end
  end


end
