require 'rails_helper'

RSpec.describe 'Home Page' do
  scenario 'any visitor can visit home page' do
    visit root_path

    expect(page.find_link('View Cart')[:href]).to eq('/cart')
    expect(page.find_link('Outings')[:href]).to eq(outings_path)
  end
end