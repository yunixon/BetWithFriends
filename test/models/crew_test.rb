require 'test_helper'

class CrewTest < ActiveSupport::TestCase

	test "should not save crew without a name" do
  	crew = get_crew(nil)
  	assert !crew.save, "a crew could be saved without a name"
	end

	test "crew name is unique" do
		crew1 = get_crew("saien supa crew")
		assert crew1.save, "the first crew could not be saved"

		crew2 = get_crew(crew1.name)
		assert !crew2.save, "2 crews can have the same name !"
	end

	def get_crew(name)
		crew = Crew.new
		crew.name = name
		return crew
	end

end
