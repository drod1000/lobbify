require 'rails_helper'

describe "Visitor" do
  scenario "adds items to cart with intention of buying them" do
    politician = create(:politician)
    outing_1, outing_2 = create_list(:outing, 2, politician: politician)

    visit root_path

    within "#outing-index:nth-of-type(1)" do
      click_on "Add to Cart"
      click_on "Add to Cart"
    end

    click_on "View Cart"
    click_on "Checkout"
    click_on "Create Account"

    within "form" do
      fill_in 'user[name]', with: "Jerry"
      fill_in 'user[email]', with: "jerrysokewl@email"
      fill_in 'user[password]', with: 'jerrysokewl'
      click_on 'Create User'
    end

    click_on 'View Cart'

    expect(current_path).to eq(cart_path)
    expect(page).to have_content(outing_1.title)
    within '#quantity:nth-of-type(1)' do
      expect(page).to have_content(2)
    end
  end
end
