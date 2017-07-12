module GoFlippy
  class Poller
    def initialize(polling_interval, http_client, store)
      @polling_interval = polling_interval
      @http_client = http_client
      @store = store
    end

    def start
      # TODO: Implement logger
      Worker.create(@polling_interval) do
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
end
