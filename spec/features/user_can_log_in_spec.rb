require 'rails_helper'

RSpec.feature "User can log in" do
  it "from root" do
    user = User.create(name: "Daniel", email: "d@d.com", password: "password")
    visit root_path

    expect(page).to have_link("Login")
    click_on "Login"

    expect(current_path).to eq(login_path)

    within("form") do
      fill_in "email", with: user.email
      fill_in "password", with: user.password
      click_on "Login"
    end

    expect(current_path).to eq (dashboard_path)
    expect(page).to have_content("Successfully created acount!")
    expect(page).to have_content("Logged in as Daniel")
    expect(page).to have_content("Name: Daniel")
    expect(page).to have_content("Email: d@d.com")
    expect(page).to_not have_link("Login")
    expect(page).to have_link("Logout")
  end
end
