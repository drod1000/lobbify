require 'rails_helper'

describe "Admin logs in" do
  scenario "and edits an existing user into an admin" do
    admin = User.create(name: "Drew", email: "email@email.com", password: "password", role: 1)
    user  = User.create(name: "Laszlo", email: "email2@email.com", password: "1password", role: 0)

    visit admin_users_path

    within "table" do
      expect(page).to have_content("Laszlo")
      expect(page).to have_content("Default")
    end

    within "table" do
      click_on "Make Admin"
    end

    within "table" do
      expect(page).to have_content("Laszlo")
      expect(page).to have_content("Admin")
      expect(page).to_not have_content("Make Admin")
    end
    expect(current_path).to eq(admin_users_path)
  end
end
