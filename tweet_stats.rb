
module TweetStats
  DAY, WEEK = 86400, 604800

  def actual_day(day = 0, simple = false)
    day = parse_time(day)

    matches = @tweets.select { |tweet| day.day == tweet.day && day.month == tweet.month }.sort_by &:time

    unless simple
      summary = ["\n@#{@name} tweeted #{matches.count} times on #{format_date(day)}"]
      summary += matches.map { |tweet| "#{format_time(tweet)}#{' am' if tweet.hour < 12}" }

      puts summary
    end

    matches.count || 0
  end


  def actual_week(start_time, simple = false)
    raise 'please input start_time' if start_time.class != Time || start_time >= Time.new
    raise 'wrong argument format. use: start_time, simple = true||false' unless [false, nil, true, 1].include?(simple)

    finish_time = start_time + WEEK
    matches = @tweets.select { |tweet| start_time < tweet.time && finish_time > tweet.time }.sort_by &:time

    unless simple
      start, finish = format_date(start_time), format_date(finish_time)
      time = format_time(start_time)

      summary = ["\n#{"So far " if finish_time > Time.new+1}@#{@name} tweeted #{matches.count} times from #{start}-#{finish} #{time}"]
      summary += matches.map { |tweet| "#{format_date(tweet)} at #{format_time(tweet)}#{" am" if tweet.hour < 12}" }

      puts summary
    end

    matches.count || 0
  end


  def actual_range(start_time, finish_time, simple = false)
    start_time, finish_time = parse_time(start_time), parse_time(finish_time)
    raise 'input start_time, end_time' if start_time.class != Time || start_time >= Time.new
    raise 'range should start before it ends' if finish_time <= start_time
    raise 'wrong argument format. use: start_time, finish_time, simple = true||false' unless [false, nil, true, 1].include?(simple)

    matches = @tweets.select { |tweet| start_time <= tweet.time && finish_time >= tweet.time }.sort_by &:time

    unless simple
      start = "#{format_date(start_time)} at #{format_time(start_time)}"
      finish = "#{format_date(finish_time)} at #{format_time(finish_time)}"

      summary = ["\n@#{@name} tweeted #{matches.count} times from #{start} to #{finish}"]
      summary += matches.map { |tweet| "#{format_date(tweet)} at #{format_time(tweet)}" }

      puts summary
    end

    matches.count || 0
  end


  protected

  def parse_time(time_or_offset)
    if time_or_offset.is_a? Fixnum
      Time.new + (DAY * time_or_offset)
    else
      time_or_offset
    end
  end

  private

  def format_date(time)
    if time.month == Time.new.month && time.day == Time.new.day
      "#{time.month}/#{time.day} (today)"
    else
      "#{time.month}/#{time.day}"
    end
  end

  def format_time(time)
    if time.hour == 12 && time.min == 0
      "noon"
    else
      "#{time.hour}:#{"%02d" % time.min}"
    end
  end

  def format_duration(time)
    if time < 3600
      "#{time.to_i / 60} minutes"
    elsif time < 86400
      "#{time.to_i / 3600} hours #{format_duration(time % 3600)}"
    else
      "#{time.to_i / DAY} days #{format_duration(time % DAY)}"
    end
  end

end
