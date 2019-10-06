require 'promise'
require 'user'
require 'date'
require 'text_sender'

class Scheduler

  def initialize(text_sender=TextSender.new)
    @text_sender = text_sender
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

    user_id = promise.user_id
    user_info = User.fetch_user(user_id)
    user_mobile = user_info[0].mobile
    user_name = user_info[0].firstname

    # check and send out final message
    if promise.end_datetime.to_time <= current_time
      @text_sender.send_text(user_mobile, "Hey there #{user_name}! Have you kept your promise?
        If YES, click: https://www.google.com or If NO, click: https://www.google.com")
      return
    end

    # check and send out reminder
    if current_time - promise.last_reminder_time.to_time > one_day_timedifference
      @text_sender.send_text(user_mobile, 'Test message!')
      promise.update_last_reminder_time(current_time)
    end
  end
end

if __FILE__ == $0
  Scheduler.initialize_twilio
  Scheduler.iterate_datebase
end
