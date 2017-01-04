require 'rails_helper'

RSpec.describe "visitor" do
  scenario "adds item to cart and views cart" do 
    politician = Politician.create(name: 'Dan', party: 'de', multiplier: 2, image: 't')
    first = Outing.create(title: 'th', description: 't', image_url: '/images/golf.jpg', base_cost: 4, politician: politician)
    second = Outing.create(title: 'ac', description: 'dc', image_url: '/images/dinner.jpg', base_cost: 10, politician: politician)

    visit outings_path
      # page.expect have_content("Add To Cart")
    
    within("div:nth-of-type(1)") do
      click_on("Add to Cart")
    end
    
    within("div:nth-of-type(2)") do
      click_on("Add to Cart")
    end

    click_on("View Cart")

    expect(current_path).to eq(cart_path)
    within("tr:nth-of-type(2)") do
      expect(page).to have_content(first.title)
      expect(page).to have_content(first.description)
      expect(page).to have_content(first.base_cost * politician.multiplier)
      page.find('#outing-photo')['src'].should have_content(first.image_url)
    end
    within("tr:nth-of-type(3)") do
      expect(page).to have_content(second.title)
      expect(page).to have_content(second.description)
      expect(page).to have_content(second.base_cost * politician.multiplier)
      page.find('#outing-photo')['src'].should have_content(second.image_url)
    end
    expect(page).to have_content("Total Price: $28.00")
  end
end