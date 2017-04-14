
module TweetAverage
  #average_day_of_week
  #average_week
  #average_range (bases averages on range of directly preceeding weeks)
  #average_all_days

  def average_day_of_week(start_time = 0, sample_count = 4, simple = false)
    raise 'wrong argument format. use: start_time||offset, sample_count, simple = true||false' if sample_count.class != Fixnum
    current = parse_time(start_time) - WEEK * (sample_count + 1)
    total = 0

    sample_count.times do
      total += actual_day(current, simple)
      current += WEEK
    end
    average_tweets = total / sample_count.to_f.round(5)

      puts "On #{current.strftime('%A')}s, @#{@name} tweets #{average_tweets} times on average (#{sample_count} samples)"

    average_tweets
  end


  def average_week(start_time = 0, sample_range = 4, simple = false)
    range_start = parse_time(start_time) - WEEK * (sample_range + 1)
    total = 0

    sample_range.times do
      total += actual_week(range_start, simple)
      range_start += WEEK
    end
    average_tweets = total / sample_range.to_f.round(5)

    unless simple
      puts "\n@#{@name} tweets an average of #{average_tweets} times per week (based on #{sample_range} weeks)"
    end

    average_tweets
  end



  def average_all_days(sample_count = 4, simple = true)
    #return error if there is no tweet data for that time period
    average_tweets = [Time.new.strftime('%A')]
    0.upto 6 do |i|
      average_tweets << average_day_of_week(offset = i, sample_count, simple)
    end
    average_tweets
  end

end
