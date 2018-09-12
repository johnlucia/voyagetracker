class AccountCreator
  def initialize(email, text)
    @email = email
    @text = text

    if PositionUpdater.new("", @text).get_position_from_text
      create_boat
      set_first_position
      send_instruction_email
    else
      # do nothing?
    end
  end

  def create_boat
    @boat = Boat.create(tracking_email: @email, user_key: SecureRandom.hex(3))
  end

  def set_first_position
    PositionUpdater.new(@boat, @text).update
  end

  def send_instruction_email  
    api_url = "https://api:#{ENV['MAILGUN_API_KEY']}@api.mailgun.net/v2/passagetracker.com"

    RestClient.post "#{api_url}/messages",
      from: "noreply@passagetracker.com",
      to: @email,
      subject: "Your New Tracking Page",
      text: welcome_email_text
  end

  def welcome_email_text
    "Hello,\n" +
    "Thank you for using PassageTracker!\n" +
    "Your tracking page can be found at #{@boat.tracking_page} .\n" +
    "If you would like to customize your tracking page with your boat name, please create a free account at https://passagetracker.herokuapp.com/users/sign_up \n" +
    "Your new account key is: #{@boat.user_key}"
  end
end