class PositionUpdater
  def initialize(boat, text)
    @boat = boat
    @text = text

    get_position_from_text
  end

  def update
    return unless @position

    @boat.positions.create(
      latitude: @position[:lat],
      longitude: @position[:lon]
    )
  end

  def get_position_from_text
    ll_regex=/(latitude|longitude|long|lat|lon|longitude|lng)(\D*-?)(0|[1-9]\d*\.\d+)?/i
    matches = @text.scan(ll_regex)

    return nil unless matches

    lat_entry = matches.find { |entry| entry[0] =~ /^lat/i }
    lon_entry = matches.find { |entry| entry[0] =~ /^(lon|lng)/i }

    return nil unless lat_entry && lon_entry

    latitude_value = "#{'-' if lat_entry[1].include?("-")}#{lat_entry.last}".to_f
    longitude_value = "#{'-' if lon_entry[1].include?("-")}#{lon_entry.last}".to_f

    return nil unless latitude_value && longitude_value

    @position = { lat: latitude_value, lon: longitude_value }
  end
end