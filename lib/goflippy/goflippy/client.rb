module GoFlippy
  class Client
    def initialize(api_key, config)
      @api_key = api_key
      @config = config || Config.default
      @store = MemoryStore.new()
      @http_client = HttpClient.new(
        @api_key,
        @config.api_uri,
        @config.open_timeout,
        @config.read_timeout
      )
      @poller = Poller.new(@config.polling_interval, @http_client, @store)
    end

    def start
      # TODO: Implement logger
      @poller.start
    end

    def enabled?(key, uid)
      uids = @store.find(key)
      uids[uid.to_sym]
    end
  end
end
