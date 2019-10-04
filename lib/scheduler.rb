require 'promise'
require 'user'
require 'date'
require 'text_sender'

class Scheduler
  attr_reader :client

  def initialize(twilio_client=TextSender.new)
    @client = twilio_client
  end

  def iterate_database
    while true
      Promise.all.each do |promise|
        process(promise)
      end

      sleep(60)
    end
  end

  def process(promise)
    current_time = DateTime.now.to_time
    one_day_timedifference = 3600 * 24

    if current_time - promise.last_reminder_time.to_time > one_day_timedifference &&
      current_time < promise.end_datetime.to_time

      user_id = promise.user_id
      user_info = User.fetch_user(user_id)
      user_mobile = user_info[0].mobile

      @client.messages.create(
      from: @from,
      to: user_mobile,
      body: "WOW, this is magic!"
      )

      promise.update_last_reminder_time(current_time)
    end
  end
end

if __FILE__ == $0
  Scheduler.initialize_twilio
  Scheduler.iterate_datebase
end
