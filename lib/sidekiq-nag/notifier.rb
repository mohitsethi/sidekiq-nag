class Sidekiq::Nag::Notifier
  attr_reader :notifier

  def initialize
    @notifier = config.uses_campfire? ? Sidekiq::Nag::Notifiers::Campfire.new : Sidekiq::Nag::Notifiers::Hipchat.new
  end

  def nag_about_queue(queue, timeout)
    notifier.nag_about_queue(queue, timeout)
  end

  private
    def config
      @config ||= Sidekiq::Nag::Config.new
    end
end