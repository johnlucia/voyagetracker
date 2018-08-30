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

    boat.positions.create(
      latitude: 1.111,
      longitude: -123.16056
    )
  end


  # ll_regex=/(latitude|longitude|long|lat|lon|longitude|lng)(\D*-?)(0|[1-9]\d*)(\.\d+)?/i
  # message_body.scan(ll_regex)
end
