require 'rails_helper'

describe "Admin views orders" do
  before(:each) do
    @admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    @order_1, @order_2, @order_3, @order_4 = create_list(:order, 4)

    @order_1.update(status: "ordered")
    @order_2.update(status: "paid")
    @order_3.update(status: "cancelled")
    @order_4.update(status: "completed")
  end
  scenario "and can see All orders" do
    visit admin_dashboard_path

    within("#all") do
      within("tr:nth-of-type(2)") do
        expect(page).to have_content(@order_1.id)
        expect(page).to have_link("Cancel")
        expect(page).to have_link("Mark as Paid")
        expect(page).not_to have_link("Mark as Completed")
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
    within ("#admin-tabs") do
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

  scenario "and can see PAID orders" do
    visit admin_dashboard_path

    within("#admin-tabs") do
      click_on "Paid"
    end

    within("#paid") do
      within("tr:nth-of-type(2)") do
        expect(page).to have_content(@order_2.id)
        expect(page).to have_link("Cancel")
        expect(page).not_to have_link("Mark as Paid")
        expect(page).to have_link("Mark as Completed")
      end

      expect(page).not_to have_content(@order_1.id)
      expect(page).not_to have_content(@order_3.id)
      expect(page).not_to have_content(@order_4.id)
    end

    within ("#admin-tabs") do
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

  scenario "and can see CANCELLED orders" do
    visit admin_dashboard_path

    within("#admin-tabs") do
      click_on "Cancelled"
    end

    within("#cancelled") do
      within("tr:nth-of-type(2)") do
        expect(page).to have_content(@order_3.id)
        expect(page).not_to have_link("Cancel")
        expect(page).not_to have_link("Mark as Paid")
        expect(page).not_to have_link("Mark as Completed")
      end

      expect(page).not_to have_content(@order_1.id)
      expect(page).not_to have_content(@order_2.id)
      expect(page).not_to have_content(@order_4.id)
    end

    within ("#admin-tabs") do
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

  scenario "and can see COMPLETED orders" do
    visit admin_dashboard_path

    within("#admin-tabs") do
      click_on "Completed"
    end

    within("#completed") do
      within("tr:nth-of-type(2)") do
        expect(page).to have_content(@order_4.id)
        expect(page).not_to have_link("Cancel")
        expect(page).not_to have_link("Mark as Paid")
        expect(page).not_to have_link("Mark as Completed")
      end

      expect(page).not_to have_content(@order_1.id)
      expect(page).not_to have_content(@order_2.id)
      expect(page).not_to have_content(@order_3.id)
    end

    within ("#admin-tabs") do
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

  scenario "and cancels an order" do
    visit admin_dashboard_path

    within("#all") do
      within("tr:nth-of-type(2)") do
        expect(page).to have_content(@order_1.id)
        click_on "Cancel"
      end
    end

    expect(current_path).to eq admin_dashboard_path

    within ("#admin-tabs") do
      within("li:nth-of-type(2)") do
        expect(page).to have_content("0")
      end

      within("li:nth-of-type(4)") do
        expect(page).to have_content("2")
      end
    end
  end

  scenario "and marks an order as paid" do
    visit admin_dashboard_path

    within("#all") do
      within("tr:nth-of-type(2)") do
        click_on "Mark as Paid"
      end
    end

    expect(current_path).to eq admin_dashboard_path

    within ("#admin-tabs") do
      within("li:nth-of-type(2)") do
        expect(page).to have_content("0")
      end

      within("li:nth-of-type(3)") do
        expect(page).to have_content("2")
      end
    end
  end

  scenario "and marks an order as completed" do
    visit admin_dashboard_path

    within("#all") do
      within("tr:nth-of-type(3)") do
        click_on "Mark as Completed"
      end
    end

    expect(current_path).to eq admin_dashboard_path

    within ("#admin-tabs") do
      within("li:nth-of-type(3)") do
        expect(page).to have_content("0")
      end

      within("li:nth-of-type(5)") do
        expect(page).to have_content("2")
      end
    end
  end

end
