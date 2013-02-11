class Sidekiq::Nag::Railtie < Rails::Railtie
  require 'sidekiq-nag/middleware/timestamper'

  initializer :after do
    Sidekiq.configure_server do |config|
      config.server_middleware do |chain|
        chain.add Sidekiq::Nag::Middleware::Timestamper
      end
    end

    Sidekiq.configure_client do |config|
      config.client_middleware do |chain|
        chain.add Sidekiq::Nag::Middleware::Timestamper
      end
    end
  end

  rake_tasks do
    load "tasks/nag.rake"
  end
end
