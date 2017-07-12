module GoFlippy
  class Client
    def initialize(api_key, opts = {})
      @api_key = api_key
      @config = opts&.empty? ? Config.default : Config.new(opts)
      @store = MemoryStore.new
      @http_client = HttpClient.new(@api_key, @config)
      @poller = Poller.new(@config.polling_interval, @http_client, @store)
      @processor = Processor.new(@http_client)
    end

    def start
      # TODO: Implement logger
      @poller.start
      @processor.start
    end

    def enabled?(key, uid)
      uids = @store.find(key)
      uids[uid.to_sym]
    end
  end
end
