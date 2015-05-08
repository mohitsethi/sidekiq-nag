module Sidekiq::Nag::Notifiers
  class Slack
    require 'slack-notifier'

    attr_reader :notifier, :channel, :user

    def initialize
      @notifier = ::Slack::Notifier.new(config.webhook)
      @channel = config.channel
      @user = config.user
    end

    def nag_about_queue(queue, timeout)
      message = ":no_bicycles: excuse me, the '#{queue}' queue has been chilling for at least #{timeout} minutes..."
      notifier.ping message, username: user, channel: channel
    end

    private
      def config
        @config ||= Sidekiq::Nag::Config.new
      end
  end
end
