require 'rails_helper'

describe 'Admin' do
  scenario 'successfully visits admin dashboard' do
    admin = User.create(name: "Drew", email: "email@email.com", password: "password", role: 1)
    page.set_rack_session(user_id: admin.id)

    visit '/admin/dashboard'

    expect(page).to have_content("Admin Dashboard")
  end

  scenario 'redirected to admin dashboard upon login' do
    admin = User.create(name: "Drew", email: "email@email.com", password: "password", role: 1)

    visit login_path
    within("form") do 
      fill_in "email", with: "email@email.com"
      fill_in "password", with: "password"
      click_on "Login"
    end

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Admin Dashboard")
  end
end