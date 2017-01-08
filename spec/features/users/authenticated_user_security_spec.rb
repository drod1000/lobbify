require 'rails_helper'

describe "Authenticated User logs in" do
  scenario "and cannot make themselves an admin" do
    admin = User.create(name: "Drew", email: "email@email.com", password: "password", role: 1)
    user  = User.create(name: "Laszlo", email: "email2@email.com", password: "1password", role: 0)

    page.set_rack_session(user_id: user.id)

    visit '/admin/users'

    expect(page).to have_content("Access forbidden.")
    expect(page).to_not have_content("Make Admin")
  end
end
