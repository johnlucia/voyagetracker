class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    address = @email.from[:email]
    text = @email.body

    boat = Boat.find_by_tracking_email(address)

    if boat
      PositionUpdater.new(boat, text).update
    else
      AccountCreator.new(address, text)
    end
  end
end
