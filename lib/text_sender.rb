require 'twilio-ruby'

class TextSender
  def initialize
    account_sid = 'INPUT TWILIO SID'
    auth_token = 'INPUT TWILIO AUTH TOKEN'
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    @from = '+441442800614' # Your Twilio number
  end

end
