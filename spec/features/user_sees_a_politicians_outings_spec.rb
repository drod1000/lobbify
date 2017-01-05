require 'rails_helper'

RSpec.feature "visitor visits '/politicians_name'" do
  scenario "they can view all outings related to politician" do

    politician = create(:politician)
    outing_1, outing_2 = create_list(:outing, 2, politician: politician)

    visit categories_path(politician.name)

    expect(page).to have_content(politician.name)
    expect(page).to have_content(outing_1.title)
    expect(page).to have_content(outing_2.title)
  end
end
