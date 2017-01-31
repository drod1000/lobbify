require 'rails_helper'

RSpec.feature "User log in" do

  before(:each) do
    @user = User.create(name: "Daniel", email: "d@d.com", password: "password")
    @user2 = User.create(name: "user2", email: "user2@user2.com", password: "user2")
  end
  it "can log in with proper credentials from home page" do
    visit root_path

    expect(page).to have_link("Login")
    click_on "Login"

    expect(current_path).to eq(login_path)

    within("form") do
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      click_on "Login"
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Logged in as Daniel")
    expect(page).to have_content("Name: Daniel")
    expect(page).to have_content("Email: d@d.com")
    expect(page).to_not have_link("Login")
    expect(page).to have_link("Logout")
  end
  it "cannot log in from home page with email that is not in user database" do
    visit root_path

    expect(page).to have_link("Login")
    click_on "Login"

    expect(current_path).to eq(login_path)

    within("form") do
      fill_in "email", with: "incorrect_email"
      fill_in "password", with: @user.password
      click_on "Login"
    end

    expect(current_path).to eq(login_path)
    expect(page).to have_content('Failed login')
    expect(page).to have_link('Login')
    expect(page).not_to have_link('Logout')
  end

  it "cannot log in from home page with email of another user" do
    visit root_path

    expect(page).to have_link("Login")
    click_on "Login"

    expect(current_path).to eq(login_path)

    within("form") do
      fill_in "email", with: @user2.email
      fill_in "password", with: @user.password
      click_on "Login"
    end

    expect(current_path).to eq(login_path)
    expect(page).to have_content('Failed login')
    expect(page).to have_link('Login')
    expect(page).not_to have_link('Logout')
  end

  scenario "and sees link to admin dashboard and admin outings index" do
    admin = User.create(name: "Drew", email: "email@email.com", password: "password", role: 1)
    user  = User.create(name: "Laszlo", email: "email2@email.com", password: "1password", role: 0)

    page.set_rack_session(user_id: user.id)

    visit root_path

    expect(page).to_not have_link("Outings Index")
    expect(page).to_not have_link("Admin Dashboard")
  end
end
