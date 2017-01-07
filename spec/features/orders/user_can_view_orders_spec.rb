require 'rails_helper'

RSpec.describe 'User views orders' do
  it 'can view own order history' do
    test_user1, test_user2 = create_list(:user, 2)
    order1, order2 = create_list(:order, 2, user: test_user1)
    order3, order4 = create_list(:order, 2, user: test_user2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(test_user1)

    visit '/orders'

    within("table") do
      expect(page).to have_content("#{order1.id}")
      expect(page).to have_content("#{order2.id}")
      expect(page).not_to have_content("#{order3.id}")
      expect(page).not_to have_content("#{order4.id}")
    end
  end
end