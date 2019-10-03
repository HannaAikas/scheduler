require 'promise'
require 'twilio-ruby'

class Scheduler
  def iterate_database
    while true
      @promises = Promise.all

      @promises.each do |promise|
        time_of_promise = promise.created_at

        users_id = promise.users_id
        users_info = User.fetch_user(users_id)
        to = users_info.mobile
      end

      sleep(60)
    end
  end

  def initilize_twilio
    # REMINDER - MOVE THIS INTO ENV, BEFORE PUSHING TO GITHUB
    account_sid = 'INPUT TWILIO SID'
    auth_token = 'INPUT TWILIO AUTH TOKEN'
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    @from = '+441442800614' # Your Twilio number
  end



  @client.messages.create(
  from: @from,
  to: to,
  body: "WOW, this is magic!"
  )

end
