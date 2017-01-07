require "rails_helper"

describe OrderItem do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid without an order_id' do
        order_outing = OrderItem.create(outing_id: 1, quantity: 1)

        expect(order_outing).to be_invalid
      end

      it 'is invalid without an outing_id' do
        order_outing = OrderItem.create(order_id: 1, quantity: 1)

        expect(order_outing).to be_invalid
      end

      it 'is invalid without a quantity' do
        order_outing = OrderItem.create(order_id: 1, outing_id: 1)

        expect(order_outing).to be_invalid
      end
    end

    context 'valid attributes' do
      it 'is valid with all attributes' do
        order_outing = OrderItem.create(order_id: 1, outing_id: 1, quantity: 1)

        expect(order_outing).to be_invalid
      end
    end
  end

  describe 'relationships' do
    it 'belongs to an order' do
      order_outing = OrderItem.create(order_id: 1, outing_id: 1, quantity: 1)

      expect(order_outing).to respond_to(:order)
    end

    it 'belongs to an outing' do
      order_outing = OrderItem.create(order_id: 1, outing_id: 1, quantity: 1)

      expect(order_outing).to respond_to(:outing)
    end
  end
end
