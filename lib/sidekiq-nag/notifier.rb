class Sidekiq::Nag::Notifier
  require 'tinder'

  def initialize
    campfire = Tinder::Campfire.new(config.subdomain, :token => config.token)
    @room = campfire.find_room_by_name(config.room)
  end

  def nag_about_queue(queue, timeout)
    room.speak(":no_good: excuse me, the '#{queue}' queue has been chilling for at least #{timeout} minutes...")
  end

  private
    attr_reader :room

    def config
      @config ||= Sidekiq::Nag::Config.new
    end
end