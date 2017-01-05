require 'rails_helper'

RSpec.describe "visitor" do
  scenario "removes item from the cart and views cart" do 
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

    visit cart_path

    # save_and_open_page

    within("tr:nth-of-type(2)") do
      click_on("Remove")
    end

    expect(current_path).to eq(cart_path)
    expect(page).to have_content("Successfully removed #{first.title} from your cart.")
    # expect(page).to have_link(carts_path(outing_id: first.id))
  end
end