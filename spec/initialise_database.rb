require 'pg'

def initialise_database
  conn = PG.connect(dbname: 'iPromise_test')
  conn.exec("TRUNCATE promises RESTART identity CASCADE;")
  conn.exec("TRUNCATE users RESTART identity CASCADE;")

  conn.exec("INSERT INTO users (created_at, updated_at, email,
    encrypted_password, remember_token, firstname, mobile) VALUES (
      current_timestamp, current_timestamp, '1x@test.com', 'password',
      'remember_token', 'test_name1', '+447500000000')")

  conn.exec("INSERT INTO users (created_at, updated_at, email,
    encrypted_password, remember_token, firstname, mobile) VALUES (
      current_timestamp, current_timestamp, '2x@test.com', 'password',
      'remember_token', 'test_name2', '+447500000000')")

  conn.exec("INSERT INTO promises (created_at, updated_at, text, end_datetime,
    interval, user_id, last_reminder_time, status) VALUES (current_timestamp, current_timestamp,
      'test_promise1', timestamp '2020-03-01', '2 days', '1', timestamp '2019-10-2', 'true')")

  conn.exec("INSERT INTO promises (created_at, updated_at, text, end_datetime,
    interval, user_id, last_reminder_time, status) VALUES (current_timestamp, current_timestamp,
      'test_promise2', timestamp '2022-03-01', '2 days', '2', timestamp '2019-12-2', 'true')")
end
