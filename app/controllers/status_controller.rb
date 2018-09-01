class StatusController < ApplicationController

  def index
    @boat = Boat.find params[:boat_id]
    @positions = @boat.positions.order(created_at: :desc).limit(2)

    previous_report = @positions.last
    current_report = @positions.first

    previous_position = [previous_report.latitude, previous_report.longitude]
    current_position = [current_report.latitude, current_report.longitude]

    seconds_between_reports = (current_report.created_at - previous_report.created_at).to_i.abs
    distance_between_reports = Geocoder::Calculations.distance_between(previous_position, current_position, units: :nm)
    nm_per_second = distance_between_reports / seconds_between_reports

    puts "\n\n\n\n\n\n\n\n"
    puts "nm_per_second: #{nm_per_second}"
    puts "seconds_between_reports: #{seconds_between_reports}"
    puts "distance_between_reports: #{distance_between_reports}"
    puts "\n\n\n\n\n\n\n\n"

    @last_update = current_report.created_at
    @speed_in_knots = (nm_per_second * 3600).round(1)
    @heading = Geocoder::Calculations.bearing_between(previous_position, current_position).round(2)
    @status = @speed_in_knots > 0.1 ? "Underway" : "Stationary"
    @latitude = current_report.latitude
    @longitude = current_report.longitude

    respond_to do |format|
      format.html { render :index }
      # format.json { render json: @positions, root: 'status', adapter: :json }
    end
  end
end
