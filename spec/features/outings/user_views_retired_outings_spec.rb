require 'rails_helper'

RSpec.feature "Visitor can view a retired outing" do
  it "cannot add retired outing to cart from show" do
    politician = Politician.create(name: 'DTrump', party: 'R', multiplier: 2, image: '/images/golf.jpg')
    outing = politician.outings.create(title: 'test', description: 'test-description', image_url: '/images/golf.jpg', base_cost: 4, status: 1)

    visit outing_path(outing)

    expect(page).to have_content("Outing Retired")
    expect(page).to have_content("test")
    expect(page).to have_content("test-description")
    expect(page).not_to have_content("Add to Cart")
  end

  it "can add active outing to cart from show" do
    politician = Politician.create(name: 'DTrump', party: 'R', multiplier: 2, image: '/images/golf.jpg')
    outing = politician.outings.create(title: 'test', description: 'test-description', image_url: '/images/golf.jpg', base_cost: 4, status: 0)

    visit outing_path(outing)

    expect(page).not_to have_content("Outing Retired")
    expect(page).to have_content("test")
    expect(page).to have_content("test-description")
    expect(page).to have_content("Add to Cart")

    click_on "Add to Cart"
    expect(current_path).to eq(outings_path)
    click_on "View Cart"
    expect(page).to have_content("test")
    expect(page).to have_content("$8.00")
  end

  it "can add active outing to cart from show" do
    politician = Politician.create(name: 'DTrump', party: 'R', multiplier: 2, image: '/images/golf.jpg')
    outing = politician.outings.create(title: 'test', description: 'test-description', image_url: '/images/golf.jpg', base_cost: 4, status: 0)

    visit outing_path(outing)

    expect(page).not_to have_content("Outing Retired")
    expect(page).to have_content("test")
    expect(page).to have_content("test-description")
    expect(page).to have_content("Add to Cart")

    click_on "Add to Cart"
    expect(current_path).to eq(outings_path)
    click_on "View Cart"
    expect(page).to have_content("test")
    expect(page).to have_content("$8.00")
  end
end