
class Tweet

  def self.help
    puts "enter date like this: Tweet.new(timestamp)"
    puts "or like this: Tweet.create(m, d, h, m)"
  end

  def self.create(month, day, hour, minute)
   time = Time.stamp(month, day, hour||=12, minute||=0)
   Tweet.new(time)
  end

  attr_reader :time, :id

  def initialize(time, id)
    @time = time
    @id = id
  end

  def min
    @time.min
  end

  def hour
    @time.hour
  end

  def day
    @time.day
  end

  def month
    @time.month
  end

  def year
    @time.year
  end

end
