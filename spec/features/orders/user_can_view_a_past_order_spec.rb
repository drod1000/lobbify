require 'rails_helper'

RSpec.describe 'user views a past order' do

  before(:each) do
    @test_user1, @test_user2 = create_list(:user, 2)
    @admin_user = create(:user, role: 'admin')
    @order1, @order2 = create_list(:order, 2, user: @test_user1)
    @order3, @order4 = create_list(:order, 2, user: @test_user2)
    @outing1, @outing2, @outing3, @outing4 = create_list(:outing, 4)
    @order_outing1 = OrderOuting.create(order_id: @order1.id, outing_id: @outing1.id, quantity: 1)
    @order_outing2 = OrderOuting.create(order_id: @order1.id, outing_id: @outing2.id, quantity: 2)
    @order_outing3 = OrderOuting.create(order_id: @order3.id, outing_id: @outing3.id, quantity: 3)
    @order_outing4 = OrderOuting.create(order_id: @order3.id, outing_id: @outing4.id, quantity: 4)
  end

  describe 'admin can view details of any order' do
    it 'can open any orders' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)

      visit admin_dashboard_path

      within('#all') do
        click_on "#{@order1.id}"
      end

      expect(current_path).to eq(order_path(@order1.id))
      expect(page).to have_content(@order1.user.name)
      expect(page).to have_content(@order1.user.address)
      within('tr:nth-of-type(3)') do
        within('td:nth-of-type(2)') do
          expect(page).to have_content(@outing2.adjusted_cost_currency)
        end
      end
      within('tr:nth-of-type(3)') do
        within('td:nth-of-type(3)') do
          save_and_open_page
          expect(page).to have_content(@order_outing2.quantity)
        end
      end
    end
  end

  describe 'only users own orders when user is logged in' do
    scenario 'from own orders with ordered status' do
      @order1.status = "ordered"
      @order1.save
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@test_user1)

      visit orders_path

      within("table") do
        expect(page).to have_content("#{@order1.id}")
        expect(page).not_to have_content("#{@order3.id}")
        click_on "#{@order1.id}"
      end

      expect(current_path).to eq(order_path(@order1))
      expect(page).to have_content(@outing1.title)
      expect(page).to have_content(@order_outing1.subtotal_currency)
      expect(page).to have_content(@outing2.title)
      expect(page).to have_content(@order_outing2.subtotal_currency)
      expect(page).to have_content(@order1.status)
      expect(page).to have_content(@order1.total_currency)
      expect(page).to have_content(@order1.created_at)
      expect(page).not_to have_content(" on #{@order1.updated_at}")
    end
    scenario 'from own orders with paid status' do
      @order1.status = "paid"
      @order1.save
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@test_user1)

      visit orders_path

      within("table") do
        expect(page).to have_content("#{@order1.id}")
        click_on "#{@order1.id}"
      end

      expect(current_path).to eq(order_path(@order1))
      expect(page).to have_content(@outing1.title)
      expect(page).to have_content(@order_outing1.subtotal_currency)
      expect(page).to have_content(@outing2.title)
      expect(page).to have_content(@order_outing2.subtotal_currency)
      expect(page).to have_content(@order1.status)
      expect(page).to have_content(@order1.total_currency)
      expect(page).to have_content(@order1.created_at)
      expect(page).not_to have_content(" on #{@order1.updated_at}")
    end
    scenario 'from own orders with completed status' do
      @order1.status = "completed"
      @order1.save
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@test_user1)

      visit orders_path

      within("table") do
        expect(page).to have_content("#{@order1.id}")
        click_on "#{@order1.id}"
      end

      expect(current_path).to eq(order_path(@order1))
      expect(page).to have_content(@outing1.title)
      expect(page).to have_content(@order_outing1.subtotal_currency)
      expect(page).to have_content(@outing2.title)
      expect(page).to have_content(@order_outing2.subtotal_currency)
      expect(page).to have_content(@order1.status)
      expect(page).to have_content(@order1.total_currency)
      expect(page).to have_content(@order1.created_at)
      expect(page).to have_content(" on #{@order1.updated_at}")
    end
    scenario 'from own orders with cancelled status' do
      @order1.status = "cancelled"
      @order1.save
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@test_user1)

      visit orders_path

      within("table") do
        expect(page).to have_content("#{@order1.id}")
        click_on "#{@order1.id}"
      end

      expect(current_path).to eq(order_path(@order1))
      expect(page).to have_content(@outing1.title)
      expect(page).to have_content(@order_outing1.subtotal_currency)
      expect(page).to have_content(@outing2.title)
      expect(page).to have_content(@order_outing2.subtotal_currency)
      expect(page).to have_content(@order1.status)
      expect(page).to have_content(@order1.total_currency)
      expect(page).to have_content(@order1.created_at)
      expect(page).to have_content(" on #{@order1.updated_at}")
    end
  end
  describe 'cannot view other users orders when logged in' do
    scenario 'when try to view order from another user' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@test_user1)

      visit order_path(@order3)

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You can only view your own orders.")
    end
  end
  describe 'cannot view other any orders when not logged in' do
    scenario 'when try to view order from any user - test_user1' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)

      visit order_path(@order1)

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You can only view your own orders.")
    end
    scenario 'when try to view order from any user - test_user2' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)

      visit order_path(@order3)

      expect(current_path).to eq(root_path)
      expect(page).to have_content("You can only view your own orders.")
    end
  end
end