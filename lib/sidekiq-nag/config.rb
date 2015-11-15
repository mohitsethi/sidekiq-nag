require "erb"

module Sidekiq::Nag
  class Config
    attr_reader :queues, :campfire, :hipchat, :slack

    def initialize
      @queues = raw_yaml['queues']
      @campfire = raw_yaml['campfire']
      @hipchat = raw_yaml['hipchat']
      @slack = raw_yaml['slack']
    end

    def room
      notifier['room']
    end

    def webhook
      notifier['webhook']
    end

    def channel
      notifier['channel']
    end

    def user
      notifier['user']
    end

    def token
      notifier['token']
    end

    def subdomain
      campfire['subdomain']
    end

    def uses_campfire?
      raw_yaml.has_key?('campfire')
    end

    def uses_slack?
      raw_yaml.has_key?('slack')
    end

    private
      def notifier
        return campfire if uses_campfire?
        return slack if uses_slack?
        return hipchat
      end


      def raw_yaml
        @raw_yaml ||= YAML::load(ERB.new(File.read(config_path)).result)
      end

      def config_path
        File.join(Rails.root, "config", "sidekiq-nag.yml")
      end
  end
end
