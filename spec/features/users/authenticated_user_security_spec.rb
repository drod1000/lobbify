require 'rails_helper'

describe "Authenticated User logs in" do
  scenario "and cannot view the admin" do
    user1, user2 = create_list(:user, 2)
    order1, order2 = create_list(:order, 2, user: user1)
    order3, order4 = create_list(:order, 2, user: user2)
    outing1, outing2, outing3, outing4 = create_list(:outing, 4)
    order_outing1 = OrderOuting.create(order_id: order1.id, outing_id: outing1.id, quantity: 1)
    order_outing2 = OrderOuting.create(order_id: order1.id, outing_id: outing2.id, quantity: 2)
    order_outing3 = OrderOuting.create(order_id: order3.id, outing_id: outing3.id, quantity: 3)
    order_outing4 = OrderOuting.create(order_id: order3.id, outing_id: outing4.id, quantity: 4)

    page.set_rack_session(user_id: user1.id)
    # save_and_open_page

    visit '/orders'



  end
end
