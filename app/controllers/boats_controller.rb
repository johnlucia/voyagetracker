class BoatsController < ApplicationController
  # http_basic_authenticate_with name: ENV['BASIC_AUTH_USER'],
  #                              password: ENV['BASIC_AUTH_PASSWORD'],
  #                              except: :show

  before_action :set_boat, only: [:show, :edit, :update, :destroy]

  def index
    @boats = Boat.all
  end

  def show
    @positions = @boat.positions.order(created_at: :desc).limit(10)
  end

  def new
    @boat = Boat.new
  end

  def edit
  end

  def create
    @boat = Boat.new(boat_params)

    respond_to do |format|
      if @boat.save
        format.html { redirect_to @boat, notice: 'Boat was successfully created.' }
        format.json { render :show, status: :created, location: @boat }
      else
        format.html { render :new }
        format.json { render json: @boat.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @boat.update(boat_params)
        format.html { redirect_to @boat, notice: 'Boat was successfully updated.' }
        format.json { render :show, status: :ok, location: @boat }
      else
        format.html { render :edit }
        format.json { render json: @boat.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @boat.destroy
    respond_to do |format|
      format.html { redirect_to boats_url, notice: 'Boat was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_boat
      @boat = Boat.find(params[:id])
    end

    def boat_params
      params.require(:boat).permit(:name, :tracking_email, :user_id)
    end
end
