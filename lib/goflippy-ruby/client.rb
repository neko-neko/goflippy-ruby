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

    def enabled?(key, uid, default = false)
      uids = @store.find(key)
      cache = uids&.dig(uid.to_sym)
      if cache == nil
        enabled = @http_client.get("/users/#{uid}/features/#{key}")&.dig(:enabled)
        @store.put(key, { uid: uid.to_sym, enabled: enabled })
        return enabled
      end
      cache
    end

    def register(uid, groups = [])
      @store.put(uid, true)
      params = {
          uid: uid,
          groups: groups
      }
      @http_client.post('/users', params)
    end
  end
end
