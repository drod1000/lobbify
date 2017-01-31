require 'rails_helper'

RSpec.describe Cart, type: :model do
  before (:each) do
    @cart = Cart.new({})
  end

  scenario "can create new instance" do
    expect(@cart).not_to eq(nil)
  end

  scenario "contents is empty if initialized without any items" do
    expect(@cart.contents).to eq({})
    expect(@cart.outings_count).to eq(0)
    expect(@cart.empty?).to be_truthy
  end

  describe "add outing(s) to cart" do
    scenario "add one outing" do
      outing = Outing.create(title: 'th', description: 't', image_url: 'b', base_cost: 4)
      @cart.add_outing(outing.id)

      expect(@cart.contents).to eq({outing.id.to_s => 1})
      expect(@cart.outings_count).to eq(1)
      expect(@cart.empty?).to be_falsy
    end

    scenario "add two outings" do
      outing1 = Outing.create(title: 'th1', description: 't1', image_url: 'b1', base_cost: 4)
      outing2 = Outing.create(title: 'th2', description: 't2', image_url: 'b2', base_cost: 4)
      @cart.add_outing(outing1.id)
      @cart.add_outing(outing2.id)

      expect(@cart.contents).to eq({outing1.id.to_s => 1, outing2.id.to_s => 1})
      expect(@cart.outings_count).to eq(2)
      expect(@cart.empty?).to be_falsy
    end

    scenario "add one outing once and another outing three times" do
      outing1 = Outing.create(title: 'th1', description: 't1', image_url: 'b1', base_cost: 4)
      outing2 = Outing.create(title: 'th2', description: 't2', image_url: 'b2', base_cost: 4)
      @cart.add_outing(outing1.id)
      @cart.add_outing(outing2.id)
      @cart.add_outing(outing2.id)
      @cart.add_outing(outing2.id)

      expect(@cart.contents).to eq({outing1.id.to_s => 1, outing2.id.to_s => 3})
      expect(@cart.outings_count).to eq(4)
      expect(@cart.empty?).to be_falsy
    end
  end

  describe "calculate cart total value" do
    scenario "return total value as number" do
      politician = Politician.create(name: 'Dan', party: 'de', multiplier: 2, image: 't')
      outing1 = Outing.create(title: 'th1', description: 't1', image_url: 'b1', base_cost: 4, politician: politician)
      outing2 = Outing.create(title: 'th2', description: 't2', image_url: 'b2', base_cost: 3, politician: politician)
      @cart.add_outing(outing1.id)
      @cart.add_outing(outing1.id)
      @cart.add_outing(outing2.id)

      expect(@cart.total).to eq(22)
    end
    scenario "return total value as currency" do
      politician = Politician.create(name: 'Dan', party: 'de', multiplier: 2, image: 't')
      outing1 = Outing.create(title: 'th1', description: 't1', image_url: 'b1', base_cost: 4, politician: politician)
      outing2 = Outing.create(title: 'th2', description: 't2', image_url: 'b2', base_cost: 3, politician: politician)
      @cart.add_outing(outing1.id)
      @cart.add_outing(outing2.id)
      @cart.add_outing(outing2.id)

      expect(@cart.total_currency).to eq('$20.00')
    end

  end
end