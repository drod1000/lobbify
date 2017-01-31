require 'rails_helper'

RSpec.describe "Method path_cleaner" do
  before (:each) do
    class PathCleanerTest
      include ApplicationHelper
    end
    @tester = PathCleanerTest.new
  end

  describe "it adds spaces" do
    scenario "input is all Capitalized" do
      test_path = "Some_Name"

      expect(@tester.path_cleaner(test_path)).to eq("Some Name")
    end
    scenario "input is not capitalized" do
      test_path = "some_name"

      expect(@tester.path_cleaner(test_path)).to eq("some name")
    end
    scenario "input is upper case and lower case mixed" do
      test_path = "sOMe_naME"

      expect(@tester.path_cleaner(test_path)).to eq("sOMe naME")
    end
  end
end
