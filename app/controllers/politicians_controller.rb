class PoliticiansController < ApplicationController

  def show
    @name = path_cleaner(params[:name])
    @politician = Politician.find_by(name: @name)
  end
end
