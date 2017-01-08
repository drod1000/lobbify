require 'rails_helper'

RSpec.describe 'Visitor can checkout cart' do
  before(:each) do
    @test_user1 = create(:user)
    @outing1, @outing2, @outing3, @outing4 = create_list(:outing, 4)
  end
  scenario 'after logging in' do
    visit outings_path

    within '#outing-index:nth-of-type(1)' do
      click_on "Add to Cart"
    end
    within '#outing-index:nth-of-type(2)' do
      click_on "Add to Cart"
    end

    click_on 'View Cart'

    expect(current_path).to eq(cart_path)
    expect(page).to have_content(@outing1.title)
    expect(page).to have_content(@outing2.title)

    click_on 'Checkout'

    expect(current_path).to eq(login_path)

    within("form") do
      fill_in "email", with: @test_user1.email
      fill_in "password", with: @test_user1.password
      click_on "Login"
    end

    visit cart_path

    click_on 'Checkout'

    expect(current_path).to eq(orders_path)
    expect(page).to have_content('Order was successfully placed')
    within('table') do
      expect(page).to have_content(Order.first.id)
    end

  end
end