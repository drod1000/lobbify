require 'rails_helper'

describe Outing do
  before(:each) do
    @politician = Politician.create(name: 'Dan', party: 'de', multiplier: 2, image: 't')
  end

  describe 'validations' do
    context 'invalid attributes' do
      it 'is invalid without a title' do
        outing = Outing.create(description: 'th', image_url: 't', base_cost: 4)

        expect(outing).to be_invalid
      end

      it 'is invalid without a description' do
        outing = Outing.create(title: 'th', image_url: 't', base_cost: 4)

        expect(outing).to be_invalid
      end

      it 'is invalid without an image' do
        outing = Outing.create(title: 'th', description: 't', base_cost: 4)

        expect(outing).to be_invalid
      end

      it 'is invalid without base cost' do
        outing = Outing.create(title: 'th', description: 't', image_url: 'bob')

        expect(outing).to be_invalid
      end
    end

    context 'valid attributes' do
      it 'is valid' do
        outing = Outing.create(title: 'th', description: 't', image_url: 'b', base_cost: 4)

        expect(outing).to be_valid
      end
    end
  end

  describe 'relationships' do
    it 'belongs to a politician' do
      outing = Outing.create(title: 'th', description: 't', image_url: 'b', base_cost: 4)

      expect(outing).to respond_to(:politician)
    end

    it 'has many order_outings' do
      outing = create(:outing)

      expect(outing).to respond_to(:order_outings)
    end

    it 'has many orders' do
      outing = create(:outing)

      expect(outing).to respond_to(:orders)
    end
  end

  describe 'methods' do
    describe 'adjusted cost' do
      it 'returns base_cost multiplied by politician multiplier' do
        outing = Outing.create(title: 'th', description: 't', image_url: 'b', base_cost: 4, politician: @politician)

        expect(outing.adjusted_cost).to eq(8)
      end
    end
    describe 'adjusted cost as currency' do
      it 'returns as currency the base_cost multiplied by politician multiplier' do
        outing = Outing.create(title: 'th', description: 't', image_url: 'b', base_cost: 4, politician: @politician)

        expect(outing.adjusted_cost_currency).to eq("$8.00")
      end
    end
  end
end
