class Sidekiq::Nag::Railtie < Rails::Railtie
  rake_tasks do
    load "tasks/nag.rake"
  end
end
