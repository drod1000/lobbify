require 'rails_helper'

describe 'Visitor' do
  scenario 'unsuccessfully visits admin dashboard' do

    visit '/admin/dashboard'

    expect(page).not_to have_content("Admin Dashboard")
    expect(page).to have_content("Access forbidden")
  end
end