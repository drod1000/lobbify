require 'rails_helper'

describe "Admin" do
  scenario "can modify own (admin) account data" do
    admin = User.create(name: "Drew", email: "email@email.com", password: "password", role: 1)
    page.set_rack_session(user_id: admin.id)

    visit dashboard_path

    expect(page).to have_link("Edit User")
    click_on "Edit User"

    within("form") do
      fill_in "user_name", with: "Chicken Salad"
      fill_in "user_email", with: "chicken@salad"
      fill_in "user_password", with: "Chicken Salad"
      click_on "Update User"
    end

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Chicken Salad")
    expect(page).not_to have_content("Drew")
  end
end