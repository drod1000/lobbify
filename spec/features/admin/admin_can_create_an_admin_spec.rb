require 'rails_helper'

describe "Admin logs in" do
  scenario "and edits an existing user into an admin" do
    admin = User.create(name: "Drew", email: "email@email.com", password: "password", role: 1)
    user  = User.create(name: "Laszlo", email: "email2@email.com", password: "1password", role: 0)

    page.set_rack_session(user_id: admin.id)

    visit admin_users_path

    within "tr:nth-of-type(3)" do
      expect(page).to have_content("Laszlo")
      expect(page).to have_content("default")
    end

    within "tr:nth-of-type(3)" do
      click_on "Make Admin"
    end

    within "tr:nth-of-type(3)" do
      expect(page).to have_content("Laszlo")
      expect(page).to have_content("admin")
      expect(page).to_not have_content("Make Admin")
    end
    expect(current_path).to eq(admin_users_path)
  end

  scenario "and sees link to admin dashboard and admin outings index" do
    admin = User.create(name: "Drew", email: "email@email.com", password: "password", role: 1)
    user  = User.create(name: "Laszlo", email: "email2@email.com", password: "1password", role: 0)

    page.set_rack_session(user_id: admin.id)

    visit root_path

    expect(page).to have_link("Outings Index")
    expect(page).to have_link("Admin Dashboard")
  end
end
