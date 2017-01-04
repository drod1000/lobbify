require 'rails_helper'

RSpec.describe Cart, type: :model do
  before (:each) do
  end

  scenario "can create new instance" do
    cart = Cart.new({})

    expect(cart).not_to eq(nil)
  end
  scenario "contents is empty if initialized without any items" do
    cart = Cart.new({})

    expect(cart.contents).to eq({})    
  end
  describe "add outing(s) to cart" do
    scenario "add one outing" do
      outing = Outing.create(title: 'th', description: 't', image_url: 'b', base_cost: 4)
      cart = Cart.new({})
      cart.add_outing(outing.id)

      expect(cart.contents).to eq({outing.id.to_s => 1})
    end
    scenario "add two outings" do
      outing1 = Outing.create(title: 'th1', description: 't1', image_url: 'b1', base_cost: 4)
      outing2 = Outing.create(title: 'th2', description: 't2', image_url: 'b2', base_cost: 4)
      cart = Cart.new({})
      cart.add_outing(outing1.id)
      cart.add_outing(outing2.id)

      expect(cart.contents).to eq({outing1.id.to_s => 1, outing2.id.to_s => 1})
    end
  end

end