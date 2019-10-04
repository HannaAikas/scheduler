require 'date'
require 'promise'

describe Promise do

  describe '#self.all' do
    it 'fetch and encapsulate entries in promise database' do
      result = Promise.all
      result = result[0]
      p result
      expect(result.text).to eq('test_promise')
      expect(result.end_datetime).to eq(DateTime.new(2020,3,1))
      expect(result.last_reminder_time).to eq(DateTime.new(2019,10,2))
      expect(result.interval).to eq('2 days')
      expect(result.user_id).to eq('1')
    end
  end
end
