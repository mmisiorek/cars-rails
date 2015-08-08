class CarsController < ApplicationController
  layout "application"

  def index
    @pageTitle = "List of all cars"
    @activePage = "allCars"

    @cars = Car.all()

    respond_to do |format|
      format.html
      format.json { render :json => @cars }
    end
  end

  def show
    @pageTitle = "Details of car #"+params[:id]
    @activePage = "carDetails"
    @car = Car.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @car }
    end
  end

  def new

  end

  def create
    @car = Car.find(params[:id])

    respond_to do |format|
      format.html
      format.json
    end
  end

end
