require 'rails_helper'

describe Politician do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid without a name' do
        politician = Politician.create(party: 'demo', multiplier: 2, image: 'thingy')

        expect(politician).to be_invalid
      end

      it 'has a unique name' do
        politician = Politician.create(name: 'Daniel', party: 'demo', multiplier: 2, image: 'thingy')
        politician_2 = Politician.create(name: 'Daniel', party: 'demo', multiplier: 2, image: 'thingy')

        expect(politician_2).to be_invalid
      end

      it 'is invalid without a party' do
        politician = Politician.create(name: 'Daniel', multiplier: 2, image: 'thingy')

        expect(politician).to be_invalid
      end

      it 'is invalid without an image' do
        politician = Politician.create(name: 'Daniel', party: 'demo', multiplier: 2)

        expect(politician).to be_invalid
      end

      it 'is invalid without a multiplier' do
        politician = Politician.create(name: 'Daniel', party: 'demo', image: 'thingy')

        expect(politician).to be_invalid
      end
    end

    context 'valid attributes' do
      it 'is has all valid attributes' do
        politician = Politician.create(name: 'Daniel', party: 'demo', multiplier: 2, image: 'thingy')

        expect(politician).to be_valid
      end
    end
  end

  describe 'relationships' do
    it 'has many outings' do
      politician = Politician.create!(name: 'Daniel', party: 'demo', multiplier: 2, image: 'thingy')

      expect(politician).to respond_to(:outings)
    end
  end
end
