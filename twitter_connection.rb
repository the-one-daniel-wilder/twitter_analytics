require 'twitter'
require 'yaml'

class TwitterConnection
  attr_reader :account, :client, :since
  # include Singleton

  def initialize(account = 'realDonaldTrump')
    @account = account
    @client = client_access
    tweets_to_doc
  end

  def tweets_to_doc(num = 200)
    tweets_raw = @client.user_timeline(@account, count: num)
    tweets = convert_tweets(tweets_raw)
    File.write("#{@account}.yml", YAML.dump(tweets))
  end


  private

  def convert_tweets(list)
    list.map { |tweet| Tweet.new(tweet.created_at, tweet.id) }
  end

  def client_access
    Twitter::REST::Client.new do |config|
      config.consumer_key        = "[redacted]"
      config.consumer_secret     = "[redacted]"
      config.access_token        = "[redacted]"
      config.access_token_secret = "[redacted]"
    end
  end

end
