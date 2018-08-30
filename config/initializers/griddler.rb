Griddler.configure do |config|
  config.processor_class = EmailProcessor
  config.email_class = Griddler::Email
  config.processor_method = :process
  config.email_service = :mailgun
end
