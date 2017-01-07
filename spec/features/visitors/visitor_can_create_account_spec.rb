require 'rails_helper'

RSpec.feature "User can create a new account" do
  scenario "from new user path" do
    visit new_user_path

    fill_in "user[name]", with: "Daniel"
    fill_in "user[email]", with: "d@d.com"
    fill_in "user[password]", with: "password"
    click_on "Create User"

    expect(current_path).to eq (dashboard_path)
    expect(page).to have_content("Successfully created acount!")
    expect(page).to have_content("Logged in as Daniel")
    expect(page).to have_content("Name: Daniel")
    expect(page).to have_content("Email: d@d.com")
    expect(page).to_not have_link("Login")
    expect(page).to have_link("Logout")
  end

  scenario "from login page" do
    visit login_path

    click_on "Create Account"

    fill_in "user[name]", with: "Daniel"
    fill_in "user[email]", with: "d@d.com"
    fill_in "user[password]", with: "password"
    click_on "Create User"

    expect(current_path).to eq ("/dashboard")
    expect(page).to have_content("Successfully created acount!")
    expect(page).to have_content("Logged in as Daniel")
    expect(page).to have_content("Name: Daniel")
    expect(page).to have_content("Email: d@d.com")
    expect(page).to_not have_link("Login")
    expect(page).to have_link("Logout")
  end

  scenario "account creation is unsuccesful" do
    visit new_user_path

    fill_in "user[email]", with: "d@d.com"
    fill_in "user[password]", with: "password"
    click_on "Create User"

    expect(current_path).to eq(users_path)
    expect(page).to have_content("Sorry, could not create account.")
  end
end
