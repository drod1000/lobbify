require 'rails_helper'

include ApplicationHelper

RSpec.feature "visitor visits '/politicians_name'" do
  describe 'through typing path into browser' do
    scenario 'they can view all outings related to politician' do

      politician_1, politician_2 = create_list(:politician, 2)
      outing_1, outing_2 = create_list(:outing, 2, politician: politician_1)
      outing_3, outing_4 = create_list(:outing, 2, politician: politician_2)

      visit "/#{path_creator(politician_1.name)}"

      expect(page).to have_content(politician_1.name)
      expect(page).to have_content(outing_1.title)
      expect(page).to have_content(outing_2.title)
      expect(page).not_to have_content(politician_2.name)
      expect(page).not_to have_content(outing_3.title)
      expect(page).not_to have_content(outing_4.title)
    end

    scenario "they type in a path for a politician that does not exist" do
      politician_1, politician_2 = create_list(:politician, 2)
      outing_1, outing_2 = create_list(:outing, 2, politician: politician_1)
      outing_3, outing_4 = create_list(:outing, 2, politician: politician_2)

      visit '/Bill_Clinton'

      expect(page).to have_content('Politician Bill Clinton does not exist.')
      expect(current_path).to eq(root_path)
    end

  end
  describe 'through outings index view' do
    scenario 'clicking on politician name they can view all outings related to politician' do

      politician_1, politician_2 = create_list(:politician, 2)
      outing_1 = create_list(:outing, 1, politician: politician_1).first
      outing_2 = create_list(:outing, 1, politician: politician_2).first

      visit outings_path

      expect(page.find_link(politician_1.name)[:href]).to eq("/#{path_creator(politician_1.name)}")
      expect(page.find_link(politician_2.name)[:href]).to eq("/#{path_creator(politician_2.name)}")

      click_on politician_1.name

      expect(current_path).to eq("/#{path_creator(politician_1.name)}")
      expect(page).to have_content(politician_1.name)
      expect(page).to have_content(outing_1.title)
      expect(page).not_to have_content(politician_2.name)
      expect(page).not_to have_content(outing_2.title)
    end
  end
end
