# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

POLLS = 1000
USERS = 10000
TIMEFRAMES = 20000
COMMENTS = 10000

poll_data = CSV.read(Rails.root.join('db', 'seeds', 'poll_seed.csv'), {col_sep: ';'})
poll_list = []

POLLS.times { |i|
  poll_list.append(
    {
      id: poll_data[i][0],
      title: poll_data[i][1],
      timeframe_start: poll_data[i][2],
      timeframe_end: poll_data[i][3],
      daily_start: poll_data[i][4],
      daily_end: poll_data[i][5],
      created_at: Time.now(),
      updated_at: Time.now()
    }
  )
}

Poll.insert_all(poll_list)

users_list = []
USERS.times { |i|
  users_list.append(
    {
      poll_id: poll_data[rand(POLLS)][0],
      name: "random_#{i+1}",
      created_at: Time.now(),
      updated_at: Time.now()
    }
  )
}

User.insert_all(users_list)

timeframe_list = []
TIMEFRAMES.times { |i|
  timeframe_list.append(
    {
      start_time: "2021-03-02 10:00:00",
      end_time: "2021-03-04 13:00:00",
      user_id: rand(1..USERS),
      tier: rand(1..3),
      created_at: Time.now(),
      updated_at: Time.now()
    }
  )
}
TimeFrame.insert_all(timeframe_list)

comments_list = []
COMMENTS.times { |i|
  comments_list.append(
    {
      body: "This is a random comment"*5,
      user_id: rand(1..USERS),
      created_at: Time.now(),
      updated_at: Time.now()
    }
  )
}
Comment.insert_all(comments_list)

