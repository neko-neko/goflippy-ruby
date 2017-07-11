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
            task
            interval = @polling_interval - (Time.now - started_at)
            sleep(interval) if interval.positive?
          rescue StandardError => e
            # TODO: Implement logger
          end
        end
      end
    end

    private

    def task
      @http_client.get('/features')&.each do |feature|
        uids = @store.find(feature[:key])
        uids.each do |uid|
          enabled = !!@http_client.get("/users/#{uid}/features/#{key}")&.dig(uid.to_sym)
          @store.put(feature[:key], { uid: uid.to_sym, enabled: enabled })
        end
      end
      @store.refresh!
    end
  end
end
