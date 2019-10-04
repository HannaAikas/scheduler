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


      #double for @client
      client_double = double("client")
      messages_double = double("messages")
      allow(client_double).to receive(:messages).and_return(messages_double)
      allow(messages_double).to receive(:create)

      allow(DateTime).to receive(:now).and_return(dt1)

      new_subject = Scheduler.new(client_double)
      # expect text
      new_subject.process(promise_double)
      # expect(new_subject.client).to have_received(:messages)

      allow(DateTime).to receive(:now).and_return(dt2)
      # not expect text
      new_subject.process(promise_double)
      expect(new_subject.client).to have_received(:messages).once
    end

  end

end
