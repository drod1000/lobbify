require 'rails_helper'

RSpec.describe "Method path_creator" do
  before (:each) do
    class PathCreatorTest
      include ApplicationHelper
    end
    @tester = PathCreatorTest.new
  end

  describe "it replaces speces" do
    scenario "input is all Capitalized" do
      test_name = "Some Name"

      expect(@tester.path_creator(test_name)).to eq("Some_Name")
    end
    scenario "input is not capitalized" do
      test_name = "some name"

      expect(@tester.path_creator(test_name)).to eq("some_name")
    end
    scenario "input is upper case and lower case mixed" do
      test_name = "sOMe naME"

      expect(@tester.path_creator(test_name)).to eq("sOMe_naME")
    end
  end
end
