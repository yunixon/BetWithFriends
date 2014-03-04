# tableless model only used for... authentication !
class Authentication 

	include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

	attr_accessor :email_address, :password

	validates :email_address, presence: true
	validates :password, presence: true

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end

end