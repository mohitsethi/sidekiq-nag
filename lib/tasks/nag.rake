namespace :'sidekiq-nag' do
  desc "Nags Sidekiq and lets you know when things aren't moving as fast you'd like"
  task :nag => :environment do
    Sidekiq.redis do |conn|
      oldest_job = conn.lindex('queue:toolkit_development', conn.llen('queue:toolkit_development') - 1)
      if JSON.parse(oldest_job)['enqueue_at'].to_f < (Time.now - 10.minutes).to_f
        Notifier.new.speak(":no_good: excuse me, the 'toolkit_development' queue has been chilling for at least 10 minutes...")
      end
    end
  end
end