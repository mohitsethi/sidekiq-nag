module Sidekiq
  module Nag
    module Middleware
      class Timestamper
        def call(worker, msg, queue, redis_pool=nil)
          msg.merge!('enqueued_at' => Time.now.to_f.to_s)
          yield
        end
      end
    end
  end
end
