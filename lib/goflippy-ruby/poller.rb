module GoFlippy
  class Poller
    include Logger

    def initialize(polling_interval, http_client, store)
      @polling_interval = polling_interval
      @http_client = http_client
      @store = store
    end

    def start
      Logger.debug('Start polling worker process')
      Worker.create(@polling_interval) do
        keys = []
        @http_client.get('/features')&.each do |feature|
          uids = @store.find(feature[:key])
          uids.each do |uid|
            enabled = @http_client.get("/users/#{uid}/features/#{key}")&.dig(:enabled)
            @store.put(feature[:key], { uid: uid.to_sym, enabled: enabled })
          end
          keys << feature[:key]
        end
        Logger.info("Polling finished. #{keys.inspect}")
        @store.refresh!(keys)
      end
    end
  end
end
