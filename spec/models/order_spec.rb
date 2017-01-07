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
    end
  end
end
