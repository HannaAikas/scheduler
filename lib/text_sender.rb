require 'twilio-ruby'

class TextSender

  TWILIO_ACCOUNT_SID = ENV['TWILIO_ACCOUNT_SID']
  TWILIO_AUTH_TOKEN = ENV['TWILIO_AUTH_TOKEN']
  TWILIO_PHONE_NUMBER = ENV['TWILIO_FROM']

  def initialize(account_sid=TWILIO_ACCOUNT_SID,
                  auth_token=TWILIO_AUTH_TOKEN,
                  caller_phone_number=TWILIO_PHONE_NUMBER)

    @client = Twilio::REST::Client.new(account_sid, auth_token)
    @from = caller_phone_number
  end

  def send_text(receiver_mobile, message)
    @client.messages.create(
    from: @from,
    to: receiver_mobile,
    body: message
    )
  end

end
