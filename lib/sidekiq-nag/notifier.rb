class Sidekiq::Nag::Notifier
  attr_reader :notifier

  def initialize
    return @notifier = Sidekiq::Nag::Notifiers::Campfire.new if config.uses_campfire?
    return @notifier = Sidekiq::Nag::Notifiers::Slack.new if config.uses_slack?
    @notifier = Sidekiq::Nag::Notifiers::Hipchat.new
  end

  def nag_about_queue(queue, timeout)
    notifier.nag_about_queue(queue, timeout)
  end

  private
    def config
      @config ||= Sidekiq::Nag::Config.new
    end
end