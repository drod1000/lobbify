require 'rails_helper'

describe "Visitor" do
  scenario "can not access Admin pages or Make Admin functionality" do
    admin = User.create(name: "Nick", email: "nick@email.com", password: "Unicorn4", role: 1)

    visit admin_users_path

    expect(page).to have_content("The page you were looking for doesn't exist.")
    expect(page).to_not have_content("Nick")
    expect(page).to_not have_content("Make Admin")
  end
end
