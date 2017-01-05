class Cart
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

end
