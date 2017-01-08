require 'rails_helper'

RSpec.describe "from outings index visitor" do
  scenario "adds active item to cart and views cart" do
    politician = Politician.create(name: 'Dan', party: 'de', multiplier: 2, image: 't')
    first = Outing.create(title: 'th', description: 't', image_url: '/images/golf.jpg', base_cost: 4, politician: politician)
    second = Outing.create(title: 'ac', description: 'dc', image_url: '/images/dinner.jpg', base_cost: 10, politician: politician)

    visit outings_path

    within("#outing-index:nth-of-type(1)") do
      click_on("Add to Cart")
    end

    within("#outing-index:nth-of-type(2)") do
      click_on("Add to Cart")
    end

    click_on("View Cart")

    expect(current_path).to eq(cart_path)
    within("tr:nth-of-type(2)") do
      expect(page).to have_content(first.title)
      expect(page).to have_content(first.description)
      expect(page).to have_content(first.base_cost * politician.multiplier)
      expect(page.find('#outing-photo')['src']).to have_content(first.image_url)
    end
    within("tr:nth-of-type(3)") do
      expect(page).to have_content(second.title)
      expect(page).to have_content(second.description)
      expect(page).to have_content(second.base_cost * politician.multiplier)
      expect(page.find('#outing-photo')['src']).to have_content(second.image_url)
    end
    expect(page).to have_content("Total Price: $28.00")
  end

  scenario "cannot add retired item to cart" do
    politician = Politician.create(name: 'Dan', party: 'de', multiplier: 2, image: 't')
    outing = politician.outings.create(title: 'th', description: 't', image_url: '/images/golf.jpg', base_cost: 4, status: 1)

    visit outings_path

    expect(page).to have_content("Outing Retired")
    expect(page).not_to have_content("Add to Cart")
  end

  scenario "visitor is redirected to login path upon checkout" do
    politician = Politician.create(name: 'Dan', party: 'de', multiplier: 2, image: 't')
    outing = politician.outings.create(title: 'th', description: 't', image_url: '/images/golf.jpg', base_cost: 4, status: 0)

    visit root_path

    within("#outing-index") do
      click_on("Add to Cart")
    end

    click_on 'View Cart'

    expect(current_path).to eq(cart_path)
    expect(page).to have_content(outing.title)

    click_on 'Login or Create Account to Checkout'

    expect(current_path).to eq(login_path)
    expect(page).to have_link("Create Account")
  end

  scenario 'visitor cannot see Checkout button on empty cart' do
    visit cart_path

    expect(page).not_to have_content('Checkout')
  end
end
