require 'date'
require 'promise'
require 'pry'

describe Promise do

  # describe '#self.all' do
  #   it 'fetch and encapsulate entries in promise database' do
  #     result = Promise.all
  #     result = result[0]
  #     expect(result.text).to eq('test_promise')
  #     expect(result.end_datetime).to eq(DateTime.new(2020,3,1))
  #     expect(result.last_reminder_time).to eq(DateTime.new(2019,10,2))
  #     expect(result.interval).to eq('2 days')
  #     expect(result.user_id).to eq('1')
  #   end
  # end

  describe '#update_last_reminder_time' do
    it "changes ‘last_reminder_time’ in promise database1" do
      new_subject = Promise.all[0]
      test_datetime = Time.new(2022,10,2)
      new_subject.update_last_reminder_time(test_datetime)
      new_subject = Promise.all[0]
      p new_subject.user_id
      expect(new_subject.last_reminder_time).to eq(test_datetime)
    end

    it "change 'last_reminder_time' in promise database2" do

      new_subject = Promise.all[1]
      p new_subject.user_id
      test_datetime = Time.new(2022,10,2)
      new_subject.update_last_reminder_time(test_datetime)
      new_subject = Promise.all[1]
      expect(new_subject.last_reminder_time).to eq(test_datetime)
    end

  end
end
