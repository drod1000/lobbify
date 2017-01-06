class PoliticiansController < ApplicationController

  def show
    @politician = path_validator(params[:name])
    if @politician.nil?
      flash[:danger] = "Politician #{path_cleaner(params[:name])} does not exist"
      redirect_to :root
    end
  end

end
