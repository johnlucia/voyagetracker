class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    boat = Boat.find_by_tracking_email(@email.from[:email])

    puts "/n/n/n/n"
    puts @email.from[:email]
    puts "/n/n/n/n"
    puts boat.inspect
    puts "/n/n/n/n #{@email.body} /n/n/n/n"

    return unless coords = lat_lon_from_text(@email.body)

    boat.positions.create(
      latitude: coords[:lat],
      longitude: coords[:lon]
    )
  end

  private

  def lat_lon_from_text(text)
    ll_regex=/(latitude|longitude|long|lat|lon|longitude|lng)(\D*-?)(0|[1-9]\d*\.\d+)?/i
    matches = text.scan(ll_regex)

    return nil unless matches

    lat_entry = matches.find { |entry| entry[0] =~ /^lat/i }
    lon_entry = matches.find { |entry| entry[0] =~ /^(lon|lng)/i }

    return nil unless lat_entry && lon_entry

    latitude_value = "#{'-' if lat_entry[1].include?("-")}#{lat_entry.last}".to_f
    longitude_value = "#{'-' if lon_entry[1].include?("-")}#{lon_entry.last}".to_f

    return nil unless latitude_value && longitude_value

    { lat: latitude_value, lon: longitude_value }
  end


  # ll_regex=/(latitude|longitude|long|lat|lon|longitude|lng)(\D*-?)(0|[1-9]\d*)(\.\d+)?/i
  # message_body.scan(ll_regex)
end
