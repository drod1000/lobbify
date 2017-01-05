class PoliticiansController < ApplicationController
  def index
    @politicians = Politician.all
  end

  def show
    @politician = Politician.find_by(name: params[:name])
  end
end
