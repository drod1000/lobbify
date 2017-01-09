class Admin::OutingsController < Admin::BaseController

  def index
    @search = Outing.search(params[:q])
    @outings = @search.result
    # @outings = Outing.all
  end

  def edit
    @outing = Outing.find(params[:id])
  end

  def update
    @outing = Outing.find(params[:id])
    @outing.update(outing_params)
    if @outing.save
      flash[:success] = "Successfully updated #{@outing.title} with #{@outing.politician.name}"
      redirect_to @outing
    else
      flash[:danger] = "Must populate all fields before updating"
      render :edit
    end
  end

  private

  def outing_params
    params.require(:outing).permit(:title, :description, :base_cost, :image_url, :status)
  end

end
