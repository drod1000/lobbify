require "rails_helper"

describe OrderItem do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid without an order_id' do
        order_item = OrderItem.create(item_id: 1, quantity: 1)

        expect(order_item).to be_invalid
      end

      it 'is invalid without an item_id' do
        order_item = OrderItem.create(order_id: 1, quantity: 1)

        expect(order_item).to be_invalid
      end

      it 'is invalid without a quantity' do
        order_item = OrderItem.create(order_id: 1, item_id: 1)

        expect(order_item).to be_invalid
      end
    end

    context 'valid attributes' do
      it 'is valid with all attributes' do
        order_item = OrderItem.create(order_id: 1, item_id: 1, quantity: 1)

        expect(order_item).to be_invalid
      end
    end
  end

  describe 'relationships' do
    it 'belongs to an order' do
      order_item = OrderItem.create(order_id: 1, item_id: 1, quantity: 1)

      expect(order_item).to respond_to(:order)
    end

    it 'belongs to an item' do
      order_item = OrderItem.create(order_id: 1, item_id: 1, quantity: 1)

      expect(order_item).to respond_to(:item)
    end
  end
end
