require 'concurrent'

module GoFlippy
  class MemoryStore
    def initialize
      @store = Concurrent::Hash.new({})
    end

    def find(key)
      @store[key]
    end

    def put(key, val)
      @store[key.to_sym] = val
    end

    def refresh!(hash)
      @store = Concurrent::Hash.new(@store.select { |k, _| hash.include?(k) })
    end
  end
end
