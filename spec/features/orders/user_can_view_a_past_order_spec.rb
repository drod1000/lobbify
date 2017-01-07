require 'rails_helper'

RSpec.describe 'user can view a past order' do
  scenario 'from own orders' do
    test_user1, test_user2 = create_list(:user, 2)
    order1, order2 = create_list(:order, 2, user: test_user1)
    order3, order4 = create_list(:order, 2, user: test_user2)
    outing = create(:outing)
    order_item = OrderItem.create(order_id: order1.id, outing_id: outing.id, quantity: 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(test_user1)

    visit orders_path

    within("table") do
      expect(page).to have_content("#{order1.id}")
      click_on "#{order1.id}"
    end

    expect(current_path).to eq(order_path(order1))
    expect(page).to have_content(outing.title)
    expect(page).to have_content(order_item.subtotal)
    expect(page).to have_content(order1.status)
    expect(page).to have_content(order1.total)
    expect(page).to have_content(order1.created_at)
  end
end