class OutingsController < ApplicationController

  def index
    @outings = Outing.all
  end

end
