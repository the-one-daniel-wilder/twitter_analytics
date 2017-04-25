
class TwitterConnection
  attr_reader :account, :client

  def initialize(account = 'realDonaldTrump')
    @account = account
    @client = client_access
    tweets_to_doc
  end

  def tweets_to_doc(num = 200)
    tweets_raw = @client.user_timeline(@account, count: num)
    tweets = convert_tweets(tweets_raw)
    tweets = tweets.sort_by &:time

    if File.exist?("./#{@account}.yml")
      # since = YAML.load_file("#{@account}.yml").last.time
      # tweets = tweets.select {|tweet| tweet.time > since}
      # File.write("#{@account}.yml", YAML.dump(tweets), IO::SEEK_SET)
    # else
      File.write("#{@account}.yml", YAML.dump(tweets))
    end

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
