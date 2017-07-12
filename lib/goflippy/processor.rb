module GoFlippy
  class Processor
    include Logger
    PROCESSING_INTERVAL = 1

    def initialize(http_client)
      @http_client = http_client
      @processing_interval = PROCESSING_INTERVAL
      @queue = Queue.new
    end

    def start
      Logger.info('Start processing worker process')
      GoFlippy::Worker.create(@processing_interval) do
        # TODO: implement here
      end
    end

  end
end
