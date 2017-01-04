require 'rails_helper'

describe Outing do
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
  end
end
