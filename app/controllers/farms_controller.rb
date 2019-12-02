class FarmsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @farms = Farm.all
  end

  def show
    @farm = Farm.find(params[:id])
  end

  def new
    @farm = Farm.new
  end

  def create
    Farm.create(farm_params)
    redirect_to farms_path
  end

  def destroy
    Farm.find(params[:id]).destroy
    redirect_to farms_path
  end

  def edit
    @farm = Farm.find(params[:id])
  end

  def update
    farm = Farm.find(params[:id])
    farm.update(farm_params)
    redirect_to farms_path
  end

  private

  def farm_params
    params.require(:farm).permit(:name, :location)
  end
end
