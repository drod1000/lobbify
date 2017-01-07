require 'rails_helper'

RSpec.describe 'user can view a past order' do
  scenario 'from own orders with ordered status' do
    test_user1, test_user2 = create_list(:user, 2)
    order1, order2 = create_list(:order, 2, user: test_user1)
    order3, order4 = create_list(:order, 2, user: test_user2)
    order1.status = "ordered"
    order1.save
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
    expect(page).not_to have_content(" on #{order1.updated_at}")
  end
  scenario 'from own orders with paid status' do
    test_user1, test_user2 = create_list(:user, 2)
    order1, order2 = create_list(:order, 2, user: test_user1)
    order3, order4 = create_list(:order, 2, user: test_user2)
    order1.status = "paid"
    order1.save
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
    expect(page).not_to have_content(" on #{order1.updated_at}")
  end
  scenario 'from own orders with completed status' do
    test_user1, test_user2 = create_list(:user, 2)
    order1, order2 = create_list(:order, 2, user: test_user1)
    order3, order4 = create_list(:order, 2, user: test_user2)
    order1.status = "completed"
    order1.save
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
    expect(page).to have_content(" on #{order1.updated_at}")
  end
  scenario 'from own orders with cancelled status' do
    test_user1, test_user2 = create_list(:user, 2)
    order1, order2 = create_list(:order, 2, user: test_user1)
    order3, order4 = create_list(:order, 2, user: test_user2)
    order1.status = "cancelled"
    order1.save
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
    expect(page).to have_content(" on #{order1.updated_at}")
  end
end