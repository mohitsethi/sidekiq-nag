module Sidekiq
  module Nag
    require "sidekiq-nag/version"
    require "sidekiq-nag/config"
    require "sidekiq-nag/notifier"
    require "sidekiq-nag/nagger"
    require "sidekiq-nag/notifiers/campfire"
    require "sidekiq-nag/notifiers/hipchat"
    require "sidekiq-nag/notifiers/slack"
    require "sidekiq-nag/railtie" if defined?(Rails)
  end
end
