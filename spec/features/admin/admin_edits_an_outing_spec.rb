require 'rails_helper'

describe "Admin" do
  scenario "successfully edits an existing outing" do
    politician = Politician.create(name: 'DTrump', party: 'R', multiplier: 2, image: '/images/golf.jpg')
    outing = politician.outings.create(title: 'test', description: 'test-description', image_url: '/images/golf.jpg', base_cost: 4, status: 0)
    admin = User.create(name: "Drew", email: "email@email.com", password: "password", role: 1)

    page.set_rack_session(user_id: admin.id)

    visit '/admin/outings'

    click_on "Edit"

    expect(current_path).to eq(edit_admin_outing_path(outing))

    within("form") do
      fill_in 'outing[title]', with: "Biking"
      fill_in 'outing[description]', with: "Ride Bike"
      fill_in 'outing[base_cost]', with: 1000
      click_on "Update Outing"
    end

    expect(current_path).to eq(outing_path(outing))
    expect(page).to have_content("Biking")
    expect(page).to_not have_content("test")
    expect(page).to have_content("Ride Bike")
    expect(page).to_not have_content("test-description")
    expect(page).to have_content(politician.name)
  end

  scenario "unsuccessfully edits an existing outing" do
    politician = Politician.create(name: 'DTrump', party: 'R', multiplier: 2, image: '/images/golf.jpg')
    outing = politician.outings.create(title: 'test', description: 'test-description', image_url: '/images/golf.jpg', base_cost: 4, status: 0)
    admin = User.create(name: "Drew", email: "email@email.com", password: "password", role: 1)

    page.set_rack_session(user_id: admin.id)

    visit '/admin/outings'

    click_on "Edit"

    expect(current_path).to eq(edit_admin_outing_path(outing))

    within("form") do
      fill_in 'outing[title]', with: ""
      click_on "Update Outing"
    end
    expect(current_path).to eq(admin_outing_path(outing))
    expect(page).to have_content("Must populate all fields before updating")
    expect(page).not_to have_content("Biking")
  end
end
