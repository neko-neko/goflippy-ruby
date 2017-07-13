module GoFlippy
  class Client
    include Logger

    def initialize(api_key, opts = {})
      @api_key = api_key
      @config = opts&.empty? ? Config.default : Config.new(opts)
      @store = MemoryStore.new
      @http_client = HttpClient.new(@api_key, @config)
      @poller = Poller.new(@config.polling_interval, @http_client, @store)
    end

    def start
      Logger.info('Start GoFlippy client')
      @poller.start
    end

    def enabled?(key, uid, default)
      uids = @store.find(key)
      uids&.dig(uid.to_sym) || default
    end
  end
end
