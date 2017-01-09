require 'rails_helper'

describe 'Admin' do
  scenario 'successfully visits admin dashboard' do
    admin = User.create(name: "Drew", email: "email@email.com", password: "password", role: 0)
    page.set_rack_session(user_id: admin.id)

    visit '/admin/dashboard'

    expect(page).not_to have_content("Admin Dashboard")
    expect(page).to have_content("Access forbidden")
  end
end