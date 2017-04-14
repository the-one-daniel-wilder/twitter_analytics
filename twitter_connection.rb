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

  # def update
  #   new_tweets = @client.user_timeline(@account, since_id: @since)
  # @since ||= new_tweets.last.id
  #   puts "updated"
  # end
  # def fetch_all
  #   last_id = [], 0
  #
  #   3.times do |i|
  #     tweets_raw = @client.user_timeline(@account, count: 600, max_id: @since)
  #     @since = tweets_raw.first.id
  #     tweets = convert_tweets(tweets_raw)
  #     File.write("#{@account}.yml", YAML.dump(tweets))
  #   end
  # end

  def tweets_to_doc(num = 200)
    tweets_raw = @client.user_timeline(@account, count: num)
    tweets = convert_tweets(tweets_raw)
    File.write("#{@account}.yml", YAML.dump(tweets))
    # @since = tweets.last.id
  end

  private

  def convert_tweets(list)
    list.map { |tweet| Tweet.new(tweet.created_at, tweet.id) }
  end

  def client_access
    Twitter::REST::Client.new do |config|
      config.consumer_key        = "vJAwBD7ffyXMKtTe24LMPIA90"
      config.consumer_secret     = "TKWrI5ctEZ4a2Amw4Ks7WNGMdsGsWfylkatt4y5k1g0UECenjs"
      config.access_token        = "180542222-RyJ1oOMUsttp6epfKJAmMRJlrBwZm55orKFCfNqI"
      config.access_token_secret = "90xcQjmVwLw5HORcXzJ7ZExOAlKSgQHQHnJZttSGMZUU7"
    end
  end

end
