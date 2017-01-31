class Cart
  include ActionView::Helpers::NumberHelper

  attr_reader :contents, :cart_content

  def initialize(initial_contents)
    @contents = initial_contents || {}
    @cart_content = {}
  end

  def add_outing(outing_id)
    @contents[outing_id.to_s] ||= 0
    @contents[outing_id.to_s] += 1
  end

  def sub_outing(outing_id)
    @contents[outing_id.to_s] -= 1
  end

  def contents_detailed
    contents.each do |outing_id, outing_qty|
      outing = Outing.find(outing_id)
      @cart_content[outing] = outing_qty
    end
    cart_content
  end

  def total
    contents_detailed.inject(0) do |cart_total, (outing, outing_qty)|
      cart_total += sub_total(outing, outing_qty)
      cart_total
    end
  end

  def sub_total(outing, quantity)
    outing.adjusted_cost * quantity
  end

  def sub_total_currency(outing, quantity)
    number_to_currency(sub_total(outing, quantity))
  end

  def total_currency
    number_to_currency(total)
  end

  def outings_count
    @contents.values.sum
  end

  def empty?
    return true if outings_count == 0
    false
  end
end
