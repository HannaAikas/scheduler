class User
  attr_reader :id, :firstname, :mobile

  def initialize(id:, firstname:, mobile:)
    @id = id
    @firstname = firstname
    @mobile = mobile
  end

  def self.fetch_user(users_id)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'iPromise_test')
    else
      connection = PG.connect(dbname: 'iPromise_development')
    end

    result = connection.exec("SELECT * FROM users WHERE id='#{users_id}'")
    result.map do |user|
      User.new(id: user['id'], firstname: user['firstname'], mobile: user['mobile'])
    end
  end
end
