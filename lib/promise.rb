require 'date'

class Promise

  attr_reader :id, :text, :end_datetime, :interval, :user_id, :created_at, :last_reminder_time

  def initialize(id:, text:, end_datetime:, interval:, user_id:, created_at:, last_reminder_time:)
    @id = id
    @text = text
    @end_datetime = end_datetime
    @interval = interval
    @user_id = user_id
    @created_at = created_at
    @last_reminder_time = last_reminder_time
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'iPromise_test')
    else
      connection = PG.connect(dbname: 'iPromise_development')
    end

    result = connection.exec("SELECT * FROM promises")
    result.map do |promise|
      Promise.new(id: promise['id'],
        text: promise['text'],
        end_datetime: DateTime.parse(promise['end_datetime']),
        interval: promise['interval'],
        user_id: promise['user_id'],
        created_at: promise['created_at'],
        last_reminder_time: DateTime.parse(promise['last_reminder_time']))
    end
  end

  def update_last_reminder_time(current_time)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'iPromise_test')
    else
      connection = PG.connect(dbname: 'iPromise_development')
    end

    sql = "UPDATE promises SET last_reminder_time = #{current_time}
        WHERE id = #{@user_id}"
    result = connection.exec(sql)


  end

end
