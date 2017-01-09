class Admin::OutingsController < Admin::BaseController

  def index
    @outings = Outing.all
  end

  def edit
    @outing = Outing.find(params[:id])
  end

  def update

  end

  private

  def outing_params
    params.require(:outing).permit(:title, :description, :base_cost)
  end

end
