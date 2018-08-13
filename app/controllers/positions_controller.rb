class PositionsController < ApplicationController

  def index
    @boat = Boat.find params[:boat_id]
    @positions = @boat.positions.order(created_at: :desc)
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @positions, root: 'route', adapter: :json }
    end
  end
end
