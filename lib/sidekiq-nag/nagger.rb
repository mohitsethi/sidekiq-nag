class Sidekiq::Nag::Nagger
  def nag
    Sidekiq.redis do |conn|
      Sidekiq::Nag::Config.new.queues.each do |queue_name, timeout|
        queue = NaggableQueue.new(conn, queue_name)

        next unless queue.exists?
        next unless queue.oldest_job_has_timestamp?

        if queue.oldest_job_timestamp.to_f < (Time.now - timeout.to_i.minutes).to_f
          Sidekiq::Nag::Notifier.new.nag_about_queue(queue_name, timeout)
        end
      end
    end
  end

  def test_nag
    Sidekiq::Nag::Notifier.new.nag_about_queue('fake_queue', 1000)
  end

  class NaggableQueue
    def initialize(connection, queue_name)
      @conn = connection
      @queue = queue_name
    end

    def exists?
      conn.exists("queue:#{queue}")
    end

    def oldest_job_timestamp
      oldest_job['enqueued_at']
    end

    def oldest_job_has_timestamp?
      oldest_job.has_key? 'enqueued_at'
    end

    def oldest_job
      @oldest_job ||= JSON.parse(conn.lindex("queue:#{queue}", conn.llen("queue:#{queue}") - 1))
    end

    private
      attr_reader :conn, :queue
  end
end