require 'date'
require 'user'

describe User do

  describe '#self.fetch_user' do
    it 'fetch and encapsulate entries in users database' do
      result = User.fetch_user(1)
      result = result[0]
      expect(result.firstname).to eq('test_name')
      expect(result.mobile).to eq('+447500000000')
    end
  end
end
