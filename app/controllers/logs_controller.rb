class LogsController < ApplicationController
  require 'rqrcode'

  def index
    @farm = Farm.find(params[:farm_id])
    @plot = Plot.find(params[:plot_id])
    @logs = @plot.logs.all


    qrcode = RQRCode::QRCode.new("http://localhost:3000/farms/1/")

    # NOTE: showing with default options specified explicitly
    png = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: 'black',
      file: nil,
      fill: 'white',
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 120
    )
    
    IO.write("logs.png", png.to_s)

  end

  def new
    @farm = Farm.find(params[:farm_id])
    @plot = Plot.find(params[:plot_id])
    @log = Log.new
  end

  def create
    @farm = Farm.find(params[:log][:farm_id])
    @plot = Plot.find(params[:log][:plot_id])
    @log = @plot.logs.create(params.require(:log).permit(:entry, :plot_id, :farm_id))

    redirect_to "/farms/#{params[:farm_id]}/plots/#{params[:plot_id]}/logs"
  end

  def edit
    @farm = Farm.find(params[:farm_id])
    @plot = Plot.find(params[:plot_id])
    @log = @plot.logs.find(params[:id])
  end

  def update
    @farm = Farm.find(params[:farm_id])
    @plot = @farm.plots.find(params[:plot_id])
    @log = @plot.logs.find(params[:id]).update(params.require(:log).permit(:entry))

    redirect_to "/farms/#{params[:farm_id]}/plots/#{params[:plot_id]}/logs"
  end

  def destroy
    @farm = Farm.find(params[:farm_id])
    @plot = @farm.plots.find(params[:plot_id])
    @log = @plot.logs.find(params[:id]).destroy

    redirect_to "/farms/#{params[:farm_id]}/plots/#{params[:plot_id]}/logs"
  end
end
