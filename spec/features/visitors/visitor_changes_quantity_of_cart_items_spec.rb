require 'rails_helper'

describe "Visitor visits the cart" do
  it "Sees quantity of items" do
    politician = create(:politician)
    outing_1, outing_2 = create_list(:outing, 2, politician: politician)

    visit '/outings'

    within '#outing-index:nth-of-type(1)' do
      click_on 'Add to Cart'
    end

    click_on 'View Cart'

    expect(current_path).to eq('/cart')
    expect(page).to have_content(outing_1.title)

    within '#quantity:nth-of-type(1)' do
      expect(page).to have_content(1)
    end
  end

  it "sees three of the same outings in the cart" do
    politician = create(:politician)
    outing_1, outing_2 = create_list(:outing, 2, politician: politician)

    visit '/outings'

    within '#outing-index:nth-of-type(1)' do
      click_on 'Add to Cart'
      click_on 'Add to Cart'
      click_on 'Add to Cart'
      click_on 'Add to Cart'
      click_on 'Add to Cart'
      click_on 'Add to Cart'
      click_on 'Add to Cart'
      click_on 'Add to Cart'
      click_on 'Add to Cart'
      click_on 'Add to Cart'
    end

    click_on 'View Cart'

    expect(current_path).to eq('/cart')
    expect(page).to have_content(outing_1.title)

    within '#quantity:nth-of-type(1)' do
      expect(page).to have_content(10)
    end
  end
  context "Visitor increments quantity in the cart" do
    it "changes  from 2 to 3" do
      politician = create(:politician)
      outing_1, outing_2 = create_list(:outing, 2, politician: politician)

      visit '/outings'

      within '#outing-index:nth-of-type(1)' do
        click_on 'Add to Cart'
        click_on 'Add to Cart'
      end

      click_on 'View Cart'

      expect(current_path).to eq('/cart')
      expect(page).to have_content(outing_1.title)

      within '#quantity:nth-of-type(1)' do
        expect(page).to have_content(2)
      end

      within '#quantity' do
        click_on '+'
      end

      within '#quantity:nth-of-type(1)' do
        expect(page).to have_content(3)
      end
      expect(current_path).to eq('/cart')
    end
  end

  context "visitor decrements the quantity in the cart" do
    it "changes from 3 to 2" do
      politician = create(:politician)
      outing_1, outing_2 = create_list(:outing, 2, politician: politician)

      visit '/outings'

      within '#outing-index:nth-of-type(1)' do
        click_on 'Add to Cart'
        click_on 'Add to Cart'
        click_on 'Add to Cart'
      end

      click_on 'View Cart'

      expect(current_path).to eq('/cart')
      expect(page).to have_content(outing_1.title)

      within '#quantity:nth-of-type(1)' do
        expect(page).to have_content(3)
      end

      within '#quantity' do
        click_on '-'
      end

      within '#quantity:nth-of-type(1)' do
        expect(page).to have_content(2)
      end
      expect(current_path).to eq('/cart')
    end

    it "hides the decrement button at quantity of 1" do
      politician = create(:politician)
      outing_1, outing_2 = create_list(:outing, 2, politician: politician)

      visit '/outings'

      within '#outing-index:nth-of-type(1)' do
        click_on 'Add to Cart'
      end

      click_on 'View Cart'

      expect(current_path).to eq('/cart')
      expect(page).to have_content(outing_1.title)
      expect(page).to_not have_link('-')
    end
  end
end
