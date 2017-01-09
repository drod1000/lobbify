require 'rails_helper'

describe "Admin views orders" do
  before(:each) do
    @admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    @order_1, @order_2, @order_3, @order_4 = create_list(:order, 4)

    @order_1.status = "ordered"
    @order_2.status = "paid"
    @order_3.status = "cancelled"
    @order_4.status = "completed"
  end
  scenario "and filters by status" do

    visit admin_dashboard_path

    within("#all") do
      within("tr:nth-of-type(2)") do
        expect(page).to have_content(@order_1.id)
        expect(page).to have_link("Cancel")
        expect(page).to have_link("Mark as Paid")
      end

      within("tr:nth-of-type(3)") do
        expect(page).to have_content(@order_2.id)
        expect(page).to have_content("Cancel")
        expect(page).to have_content("Mark as Completed")
      end

      within("tr:nth-of-type(4)") do
        expect(page).to have_content(@order_3.id)
      end

      within("tr:nth-of-type(5)") do
        expect(page).to have_content(@order_4.id)
      end
    end

    within("li:nth-of-type(1)") do
      expect(page).to have_content("4")
    end

    within("li:nth-of-type(2)") do
      expect(page).to have_content("1")
    end

    within("li:nth-of-type(3)") do
      expect(page).to have_content("1")
    end

    within("li:nth-of-type(4)") do
      expect(page).to have_content("1")
    end

    within("li:nth-of-type(5)") do
      expect(page).to have_content("1")
    end
  end
end
