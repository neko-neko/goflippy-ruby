module GoFlippy
  class Processor
    PROCESSING_INTERVAL = 0.1

    def initialize(http_client)
      @http_client = http_client
      @processing_interval = PROCESSING_INTERVAL
      @queue = Queue.new
    end

    def start
      # TODO: Implement logger
      GoFlippy::Worker.create(@processing_interval) do
        task
      end
    end

    private

    def task
      return if @queue.empty?
      # TODO: implement here
    end
  end
end
