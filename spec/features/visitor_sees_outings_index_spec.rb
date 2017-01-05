require 'rails_helper'

describe "A visitor visits '/outings'" do
  it "they see a page with all the items on it" do
    politician = Politician.create(name: "Dr", party: "R", multiplier: 1, image: "t")
    outing     = politician.outings.create(title: "golf", description: "t", base_cost: 2, image_url: "q")
    outing2    = politician.outings.create(title: "tv", description: "o", base_cost: 4, image_url: "w")

    visit '/outings'
    save_and_open_page

    expect(page).to have_content("Dr")
    expect(page).to have_content("golf")
    expect(page).to have_content("tv")
  end
end
