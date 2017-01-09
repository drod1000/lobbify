require 'rails_helper'

describe 'Admin' do
  scenario 'successfully visits admin dashboard' do
    admin = User.create(name: "Drew", email: "email@email.com", password: "password", role: 1)

    visit '/admin/dashboard'

    expect(page).to have_content("Admin Dashboard")
  end
end