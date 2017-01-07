require 'rails_helper'

RSpec.feature 'User log out' do

  before(:each) do
    @user = User.create(name: 'Daniel', email: 'd@d.com', password: 'password')
  end
  it 'can log out from home page' do
    visit login_path

    within("form") do
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      click_on "Login"
    end

    expect(page).to have_link('Logout')
    expect(page).to have_content('Logged in as Daniel')

    click_on 'Logout'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Successfully logged out')
    expect(page).to have_content('Login')
    expect(page).not_to have_content('Logout')
  end
end
