require 'scheduler'
require 'date'

describe Scheduler do
  describe "#self.process" do


    it "send reminder when (current_time - last_reminder_time) > interval" do
      dt1 = DateTime.new(2019,10,4)
      dt2 = DateTime.new(2019,10,2)

      promise_double = double("promise", :text => 'test_text',
                                        :end_datetime => DateTime.new(2020,1,1),
                                        :interval => '2 days',
                                        :user_id => 1,
                                        :last_reminder_time => DateTime.new(2019,10,2))

      allow(promise_double).to receive(:update_last_reminder_time)

      text_sender_double = double("text_sender")
      allow(text_sender_double).to receive(:send_text)
      new_subject = Scheduler.new(text_sender_double)

      # stub current time so that a reminder should be sent out
      allow(DateTime).to receive(:now).and_return(dt1)

      new_subject.process(promise_double)
      expect(text_sender_double).to have_received(:send_text)

      # stub current time so that no reminder should be sent out
      allow(DateTime).to receive(:now).and_return(dt2)
      # not expect text
      new_subject.process(promise_double)
      expect(text_sender_double).to have_received(:send_text).once
    end

  end

end
