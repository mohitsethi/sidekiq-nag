class Notifier
  def initialize
    campfire = Tinder::Campfire.new 'mbs8', :token => '3c2164cb10ad4bc14985b8c4f78191a0eee614b8'
    @room = campfire.find_by_room_name('LZ')
  end

  def speak(message = "")
    @room.speak(message)
  end
end

Sidekiq.redis do |conn|
  oldest_job = conn.lindex('queue:toolkit_development', conn.llen('queue:toolkit_development') - 1)
  if JSON.parse(oldest_job)['enqueue_at'].to_f < (Time.now - 10.minutes).to_f
    Notifier.new.speak(":no_good: excuse me, the 'toolkit_development' queue has been chilling for at least 10 minutes...")
  end
end