class LogsController < ApplicationController
<<<<<<< HEAD
  require 'rqrcode'
=======
  require "rqrcode"
>>>>>>> 4938230a89af9432f3228b52574f6ca182665d37

  def index
    @farm = Farm.find(params[:farm_id])
    @plot = Plot.find(params[:plot_id])
    @logs = @plot.logs.all
<<<<<<< HEAD


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

=======
    @path = "http://localhost:3000/farms/#{params[:farm_id]}/plots/#{params[:plot_id]}/logs"
>>>>>>> 4938230a89af9432f3228b52574f6ca182665d37
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

  def generateQrcode
    qrcode = make_qrcode(params[:format])
    send_data qrcode, type: "image/png", :disposition => "inline"
  end

  private

  def make_qrcode(path)
    qrcode = RQRCode::QRCode.new("ejemplo")
    image = qrcode.as_png(
      resize_gte_to: false,
      resize_exactly_to: false,
      fill: "white",
      color: "black",
      size: 120,
      border_modules: 4,
      module_px_size: 6,
      file: nil, # path to write
    )
    image.resize(400, 400)
  end
end
