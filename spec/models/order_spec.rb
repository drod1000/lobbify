require "rails_helper"

describe User do
  describe 'validations' do
    context 'valid attributes' do
      it 'is valid with all attributes' do
        test_user = User.create(name: "Daniel", email: "z@z.com", password: "z")
        order = Order.create(status: 0, user: test_user)

        expect(order).to be_valid
        expect(order.ordered?).to be_truthy
      end
    end

    context 'associations' do
      it 'responds to user' do
        test_user = User.create(name: "Daniel", email: "z@z.com", password: "z")
        order = Order.create(status: 0, user: test_user)

        expect(order).to respond_to(:user)
      end

      it 'has many order_outings' do
        order = create(:order)

        expect(order).to respond_to(:order_outings)
      end

      it 'has many outings' do
        order = create(:order)

        expect(order).to respond_to(:outings)
      end
    end
  end

  describe 'methods' do
    it 'can calculate total' do
      order = create(:order)
      outing_1, outing_2 = create_list(:outing, 2)
      order.order_outings.create(order_id: order.id, outing_id: outing_1.id, quantity: 3)
      order.order_outings.create(order_id: order.id, outing_id: outing_2.id, quantity: 4)

      expect(order.total).to eq((outing_1.adjusted_cost * 3 + outing_2.adjusted_cost * 4))
    end

    it 'can return total as currency' do
      order = create(:order)
      outing_1, outing_2 = create_list(:outing, 2)
      order.order_outings.create(order_id: order.id, outing_id: outing_1.id, quantity: 3)
      order.order_outings.create(order_id: order.id, outing_id: outing_2.id, quantity: 4)

      expect(order.total_currency).to eq ('$350.00')
    end
  end
end
