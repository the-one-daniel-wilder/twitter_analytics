![TA_logo](https://cloud.githubusercontent.com/assets/22918854/25199965/79fd0fb0-2501-11e7-9249-fadbbb2b2239.png)

# Twitter Analytics

Twitter Analytics calculates statistics about tweet times and frequencies.

Twitter Analytics is designed to aid in prediction of when new tweets will be released and to analyze previous patterns.
First select the account you want to track. Connect to the Twitter API. TA will grab tweet meta-data from the API and store it in a local Yaml file. You can then analyze tweet frequency using functions for statistics and averages.

-----------------------------------------------------------------------------------------------

# FEATURES

Includes connection to twitter API:
  twitter_connection

Includes Tweet class and Account class with nested modules of analytic functionality:
  - tweets
  - account < tweet_stats < tweet_average

-----------------------------------------------------------------------------------------------

# METHODS

+ TwitterConnection.new(account)          *grabs account's tweet data and drops it into yaml by default

+ Time.  
	stamp(m, d, h, m)  
	noon(offset = 0, time_zone = -3)

+ Tweet.  
	self.help  
	new(time, id)  
	create(m, d, h, m)

+ Account.  
	self.help  
	new(account, tweets)            *tweets defaults to ||= YAML.load_file("#{@name}.yml")  
	actual_day(first_day)  
	actual_week(start_date)  
	actual_range(date1, date2)  
	average_day_of_week(offset)  
	average_week(offset, range)  
	average_all_days

-----------------------------------------------------------------------------------------------

# EXAMPLES

#connect to donald trump's twitter

  TwitterConnection.new('realDonaldTrump')
  rdt = Account.new("realDonaldTrump", YAML.load_file('realDonaldTrump.yml'))  

#connect to vp's twitter

  TwitterConnection.new 'vp'
  vp = Account.new 'vp'  


#see printout and count of tweets from that day (so far, if today)

  rdt.actual_day  

#see tweets in a range from April 5th 1:28am until 2 days ago at noon

  this = Time.stamp(4, 5, 1, 28)
  that = Time.noon(-2)
  rdt.actual_range(this, that, 1)  

#see the average number of tweets on the day of the week which was one day ago

  rdt.average_day_of_week -1  

#average out the past few weeks

  rdt.average_week  

#see vp tweets for last week, starting 7 days ago at noon

  vp.actual_week(Time.noon(-7))  

#see vp tweets from Sunday

  vp.tweets.each { |t| puts "#{t.day} @ #{t.hour}:#{t.min}" if t.time.strftime('%A') == "Sunday" }  

#see average tweets for each day of the week

  vp.average_all_days

-----------------------------------------------------------------------------------------------

# DEPENDENCIES

twitter
yaml
