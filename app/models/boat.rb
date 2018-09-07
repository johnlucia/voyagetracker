class Boat < ApplicationRecord
  has_many :positions
  belongs_to :user, required: false

  def last_two_reports
    positions.order(created_at: :desc).limit(2)
  end

  def current_report
    last_two_reports.first
  end

  def previous_report
    last_two_reports.last
  end

  def current_position
    [current_report.latitude, current_report.longitude]
  end

  def previous_position
    [previous_report.latitude, previous_report.longitude]
  end

  def last_update
    current_report.created_at
  end

  def speed_in_knots
    seconds_between_reports = (current_report.created_at - previous_report.created_at).to_i.abs
    distance_between_reports = Geocoder::Calculations.distance_between(previous_position, current_position, units: :nm)
    nm_per_second = distance_between_reports / seconds_between_reports

    (nm_per_second * 3600).round(1)
  end

  def heading
    Geocoder::Calculations.bearing_between(previous_position, current_position).round(2)
  end

  def status
    speed_in_knots > 0.1 ? "Underway" : "Stationary"
  end

  def latitude
    current_report.latitude
  end

  def longitude
    current_report.longitude
  end

  def tracking_page
    "https://voyagetracker.herokuapp.com/boats/#{id}"
  end
end
