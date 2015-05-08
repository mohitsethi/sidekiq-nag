namespace :'sidekiq-nag' do
  desc "Nags Sidekiq and lets you know when things aren't moving as fast you'd like"
  task :nag => :environment do
    Sidekiq::Nag::Nagger.new.nag
  end

  desc "Tests the nag message integration"
  task :nag_test => :environment do
    Sidekiq::Nag::Nagger.new.test_nag
  end
end