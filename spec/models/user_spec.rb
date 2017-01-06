require "rails_helper"

describe User do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid without a name' do
        user = User.new(email: "z@z.com", password: "z")

        expect(user).to be_invalid
      end

      it 'is invalid without an email' do
        user = User.new(name: "Daniel", password: "z")

        expect(user).to be_invalid
      end

      it 'has a unique email' do
        user = User.create(name: "Daniel", email: "z@z.com", password: "z")
        user_2 = User.new(name: "Daniel", email: "z@z.com", password: "z")

        expect(user_2).to be_invalid
      end

      it 'is invalid without a password' do
        user = User.new(name: "Daniel", email: "z@z.com")

        expect(user).to be_invalid
      end
    end

    context 'valid attributes' do
      it 'is is valid with all attributes' do
        user = User.new(name: "Daniel", email: "z@z.com", password: "z")

        expect(user).to be_valid
      end
    end
  end
end
