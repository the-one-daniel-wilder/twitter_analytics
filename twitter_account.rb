require './tweets'
require './tweet_stats'
require './tweet_average'
require './twitter_account'
require './twitter_connection'

class Account
  extend TweetStats
  extend TweetAverage

  attr_reader :name, :tweets
  attr_accessor :range

  def initialize(name='realDonaldTrump', tweets=nil)
    @name = name
    TwitterConnection.new(name)
    tweets ||= YAML.load_file("#{@name}.yml")

    @tweets = tweets
    @range = ((Time.new - tweets.last.time) / WEEK).to_i
  end

  def self.help
    puts "commands include: actual_day(first_day), actual_week(start_date), actual_range(date1, date2), average_day_of_week(offset), average_week(offset, range), average_all_days, TwitterConnection.new(account)"
  end

  def yaml
    puts "#{@name}.yml contains tweets from #{tweets.last.time} to #{tweets.first.time}"
  end

  def count
    @tweets.count || 'please update via TwitterConnection.new(account)'
  end

end


class Time
  DAY = 86400
  def self.stamp(month, day, hour=nil, minute=nil)
    Time.new(2017, month, day, hour, minute) #timestamp = Time.stamp(m, d, h, m)
  end

  def self.noon(offset = 0, time_zone = -3)
    day = Time.new + (offset * DAY)
    Time.new(2017, day.month, day.day, 12+time_zone, 0)
  end
end
