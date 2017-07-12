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

    def refresh!(keys)
      @store = Concurrent::Hash.new(@store.select { |k, _| keys.include?(k) })
    end
  end
end
