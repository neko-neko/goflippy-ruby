require 'concurrent'

module GoFlippy
  class MemoryStore
    def initialize
      @store = Concurrent::Map.new
    end

    def find(key)
      @store[key]
    end

    def put(key, val)
      @store[key.to_sym] = val
    end
  end
end
