class ApplicationController < ActionController::Base

  def getAllCars
    render json: Car.all()
  end

end