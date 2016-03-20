require 'fileutils'

class CarsController < ApplicationController
  layout "application"

  def index
    @pageTitle = "List of all cars"
    @activePage = "allCars"

    @cars = Car.all()

    respond_to do |format|
      format.html
      format.json { render :json => { 'cars' => @cars } }
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

  def edit
    @activePage = "editCar"
    @pageTitle = "Edit car #"+params[:id]

    @car = Car.find(params[:id])
  end

  def create
    obj_params = car_params
    documentManager = ApplicationHelper::DocumentManager.new

    if obj_params[:photo] != nil
      obj_params[:photo] = documentManager.init_document(obj_params[:photo])
    end

    @car = Car.create(obj_params)
    if @car.valid?
      @car.save


      respond_to do |format|
        format.html do
          redirect_to action: 'show', id: @car.id
        end

        format.json do
          render :json => { :success => true }
        end
      end
    else
      respond_to do |format|
        format.html do
          render :template => "cars/new"
        end

        format.json do
          render :json => {
                    :success => false, 
                    :errors => @car.errors.full_messages
                 }
        end
      end
    end
  end
  
  def update
    obj_params = car_params
    if obj_params[:photo] 
      documentManager = ApplicationHelper::DocumentManager.new 
      obj_params[:photo] = documentManager.init_document(obj_params[:photo])
    end 
    
    @car = Car.find(params[:id])
    
    if obj_params[:photo]
      old_photo_path = @car.photo ? @car.photo.path_to_file : nil
    end
    
    if @car.update_attributes(obj_params)

      if obj_params[:photo] != nil and old_photo_path != nil
        FileUtils.rm old_photo_path
      end

      respond_to do |format|
        format.html do
          redirect_to action: 'show', id: @car.id
        end

        format.json do
          render :json => { 'success' => true }
        end
      end
    else
      respond_to do |format|
        format.html do
          render :template => 'cars/edit'
        end

        format.json do
          render :json => { 'success' => false, 'errors' => @car.errors.full_messages }
        end
      end
    end
  end

  def destroy
    @car = Car.find(params[:id])

    @car.destroy

    redirect_to action: 'index'
  end

  private

  def car_params
    params.require(:car).permit(:brand, :model, :is_available, :manufactured_date, :registration_number, :photo)
  end
  
end
