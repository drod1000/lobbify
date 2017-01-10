class WelcomeController < ApplicationController
  def index
    flash[:danger] = "Disclaimer! This is a parody website! We know it's impossible to buy elections anyway!"
  end
end