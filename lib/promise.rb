class Promise

  attr_reader :id, :text, :end_datetime, :interval, :users_id, :created_at

  def initialize(id:, text:, end_datetime:, interval:, users_id:, created_at:)
    @id = id
    @text = text
    @end_datetime = end_datetime
    @interval = interval
    @users_id = users_id
    @created_at = created_at
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'promise_test')
    else
      connection = PG.connect(dbname: 'promise')
    end

    result = connection.exec("SELECT * FROM promise")
    result.map do |promise|
      Promise.new(id: promise['id'], text: promise['text'], end_datetime: promise['end_datetime'], interval: promise['interval'], users_id: promise['users_id'], created_at: promise['created_at'])
    end
  end

end
