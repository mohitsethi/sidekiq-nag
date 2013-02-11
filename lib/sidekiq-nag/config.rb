module Sidekiq::Nag
  class Config
    attr_reader :queues, :campfire

    def initialize
      @queues = raw_yaml['queues']
      @campfire = raw_yaml['campfire']
    end

    def room
      campfire['room']
    end

    def token
      campfire['token']
    end

    def subdomain
      campfire['subdomain']
    end

    private
      def raw_yaml
        @raw_yaml ||= YAML::load_file(Rails.root + 'config/sidekiq-nag.yml')
      end
  end
end