require 'rails_helper'

describe "Visitor" do 
  scenario "visits root path" do
    visit root_path

    expect(page).to have_content("Disclaimer")
    expect(page.find('#small_logo')['src']).to have_content('/assets/lobbify-65196bef8c40444c2cdcab399cc124ea118b615539e6fbc862a16dafc168b2c3.png')
  end
end