class PoliticiansController < ApplicationController

  def show
    @name = params[:name].gsub("_"," ")
    @politician = Politician.find_by(name: @name)
  end
end
