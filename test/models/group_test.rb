require 'test_helper'

class GroupTest < ActiveSupport::TestCase


	test "should not save group without a name" do
  	group = get_group(nil)
  	assert !group.save, "a group could be saved without a name"
	end


	test "save and load" do
		expected = get_group("expected group")
  	assert expected.save, "the expected group could not be saved"

  	actual = Group.find(expected.id)
  	assert_equal( expected, actual, "actual group different from expected")
	end


	test "group name is unique" do
		group1 = get_group("great group")
		assert group1.save, "the first group could not be saved"

		group2 = get_group(group1.name)
		assert !group2.save, "2 groups can have the same name !"
	end


	def get_group(name)
		group = Group.new
		group.stage_id = stages(:groups_stage).id
		group.name = name
		return group
	end

end
