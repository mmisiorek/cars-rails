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
    @activePage = "newCar"

    @car = Car.new

  end

  def create
    @car = Car.create(car_params)
    if @car.valid?
      @car.save

      redirect_to action: 'show', id: @car.id
      return
    end

    redirect_to action: 'index'
  end

  def destroy
    @car = Car.find(params[:id])

    @car.destroy

    redirect_to action: 'index'
  end

  private

  def car_params
    params.require(:car).permit(:brand, :model, :is_available, :manufactured_date, :registration_number)
  end
end
