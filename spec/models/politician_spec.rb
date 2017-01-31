require "rails_helper"

describe Politician do
  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid without a name' do
        politician = Politician.create(party: 'de', multiplier: 2, image: 'th')

        expect(politician).to be_invalid
      end

      it 'has a unique name' do
        politician = Politician.create(name: 'Dan', party: 'd', multiplier: 2, image: 't')
        politician_2 = Politician.create(name: 'Dan', party: 'd', multiplier: 2, image: 't')

        expect(politician_2).to be_invalid
      end

      it 'is invalid without a party' do
        politician = Politician.create(name: 'Dan', multiplier: 2, image: 't')

        expect(politician).to be_invalid
      end

      it 'is invalid without an image' do
        politician = Politician.create(name: 'Dan', party: 'de', multiplier: 2)

        expect(politician).to be_invalid
      end

      it 'is invalid without a multiplier' do
        politician = Politician.create(name: 'Dan', party: 'de', image: 't')

        expect(politician).to be_invalid
      end
    end

    context 'valid attributes' do
      it 'is has all valid attributes' do
        politician = Politician.create(name: 'Dan', party: 'de', multiplier: 2, image: 't')

        expect(politician).to be_valid
      end
    end
  end

  describe 'relationships' do
    it 'has many outings' do
      politician = Politician.create!(name: 'Dan', party: 'de', multiplier: 2, image: 't')

      expect(politician).to respond_to(:outings)
    end
  end
end
