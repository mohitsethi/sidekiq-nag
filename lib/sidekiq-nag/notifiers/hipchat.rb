module Sidekiq::Nag::Notifiers
  class Hipchat
    require 'hipchat-api'

    attr_reader :hipchat_api

    def initialize
      @hipchat_api = HipChat::API.new(config.token)
      @room_name = config.room
    end

    def nag_about_queue(queue, timeout)
      message = "excuse me, the '#{queue}' queue has been chilling for at least #{timeout} minutes..."
      @hipchat_api.rooms_message(@room_name, 'Sidekiq-nag', message, notify = 0, colour = 'red', message_format = 'text')
    end

    private
      def config
        @config ||= Sidekiq::Nag::Config.new
      end
  end
end
