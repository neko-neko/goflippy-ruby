require 'thread'

module GoFlippy
  class Poller
    def initialize(polling_interval, http_client, store)
      @polling_interval = polling_interval
      @http_client = http_client
      @store = store
    end

    def start
      # TODO: Implement logger
      Thread.new do
        loop do
          begin
            started_at = Time.now
            poll()
            interval = @polling_interval - (Time.now - started_at)
            sleep(interval) if interval > 0
          rescue StandardError => e
            # TODO: Implement logger
          end
        end
      end
    end

    private

    def poll
      @store.each do |key, uids|
        features = {}
        uids.each do |uid|
          feature = @http_client.get("/users/#{uid}/features/#{key}")
          features[uid.to_sym] = feature['enabled']
        end
        @store.put(key, features)
      end
    end
  end
end
