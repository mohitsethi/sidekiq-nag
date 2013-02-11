module Sidekiq
  module Nag
    require "sidekiq-nag/version"
    require "sidekiq-nag/notifier"
    require "sidekiq-nag/railtie" if defined?(Rails)
  end
end
