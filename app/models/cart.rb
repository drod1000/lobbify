class Cart
  include ActionView::Helpers::NumberHelper

  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_outing(outing_id)
    @contents[outing_id.to_s] ||= 0
    @contents[outing_id.to_s] += 1
  end

  def sub_outing(outing_id)
    @contents[outing_id.to_s] -= 1
  end

  def contents_detailed
    cart_content = {}
    contents.each do |outing_id, outing_qty|
      outing = Outing.find(outing_id)
      cart_content[outing] = outing_qty
    end
    cart_content
  end

  def total
    test = contents_detailed
    contents_detailed.inject(0) do |cart_total, (outing, outing_qty)|
      cart_total += (outing.adjusted_cost * outing_qty)
      cart_total
    end
  end

  def total_currency
    number_to_currency(total)
  end

end
