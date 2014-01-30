module Sidekiq::Nag
  class Config
    attr_reader :queues, :campfire, :hipchat

    def initialize
      @queues = raw_yaml['queues']
      @campfire = raw_yaml['campfire']
      @hipchat = raw_yaml['hipchat']
    end

    def room
      notifier['room']
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

    private
      def notifier
        uses_campfire? ? campfire : hipchat
      end


      def raw_yaml
        @raw_yaml ||= YAML::load_file(Rails.root + 'config/sidekiq-nag.yml')
      end
  end
end