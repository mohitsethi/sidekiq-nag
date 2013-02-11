class Notifier
  def initialize
    campfire = Tinder::Campfire.new 'mbs8', :token => '3c2164cb10ad4bc14985b8c4f78191a0eee614b8'
    @room = campfire.find_room_by_name('LZ')
  end

  def speak(message = "")
    @room.speak(message)
  end
end