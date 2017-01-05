class PoliticiansController < ApplicationController
  
  def show
    @politician = Politician.find_by(name: params[:name])
  end
end
