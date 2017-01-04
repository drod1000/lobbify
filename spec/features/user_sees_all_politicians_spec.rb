require 'rails_helper'

RSpec.feature "User sees all politicians" do
  scenario "they can view all outings related to politicians" do

    politician_1 = create(:politician)
    outing_1, outing_2 = create_list(:outing, 2, politician: politician_1)
    politician_2 = create(:politician)
    outing_3, outing_4 = create_list(:outing, 2, politician: politician_2)

    visit politicians_path

    expect(page).to have_content(politician_1.name)
    expect(page).to have_content(politician_2.name)
    expect(page).to have_content(outing_1.name)
    expect(page).to have_content(outing_2.name)
    expect(page).to have_content(outing_3.name)
    expect(page).to have_content(outing_4.name)

  end
end
