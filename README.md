# Sidekiq::Nag

A Sidekiq extention that posts messages in Campfire when queues move slowly. A great way to prempt support calls and keep things flowing :)

## Installation

Add this line to your application's Gemfile:

    gem 'sidekiq-nag'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sidekiq-nag

## Configuration

Add a `sidekiq-nag.yml` file to the `config/` directory that looks like this:

    queues:
      foo_app_critical_queue: 10
      foo_app_low_priority_queue: 30

    campfire:
      token: NoaTOEX23...
      subdomain: foo3
      room: TheZone

The timeout entered next to each queue name is specified in minutes.

Nag provides you with a rake task that runs the queue checking and Campfire notification.
The final step in getting it to work is to setup a cron that runs `rake sidekiq-nag:nag` at intervals smaller than the timeouts you've specified in the config file. We run it once every 2 minutes :)

## How it works

Sidekiq-nag adds middleware to Sidekiq that timestamps jobs as they enter the queue. When the nag rake task is run it inspects the oldest job in the queue and checks whether its been waiting in the queue for longer than the number of minutes you've configured as the timeout.
If the job has been in the queue for longer than the timeout then Sidekiq-nag posts a message in Campfire letting you know that things aren't as great as you'd like them to be :)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
