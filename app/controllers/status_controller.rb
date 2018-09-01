class StatusController < ApplicationController

  def index
    @boat = Boat.find params[:boat_id]

    @last_update = @boat.last_update
    @speed_in_knots = @boat.speed_in_knots
    @heading = @boat.heading
    @status = @boat.status
    @latitude = @boat.latitude
    @longitude = @boat.longitude

    respond_to do |format|
      format.html { render :index }
      # format.json { render json: @positions, root: 'status', adapter: :json }
    end
  end
end
