require 'thread'

module GoFlippy
  class Worker
    def self.create(interval, &block)
      Thread.new do
        loop do
          begin
            started_at = Time.now
            yield
            sleep(interval) if (interval - (Time.now - started_at)).positive?
          rescue StandardError => e
            # TODO: Implement logger
          end
        end
      end
    end
  end
end
