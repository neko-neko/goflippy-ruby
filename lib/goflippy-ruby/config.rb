module GoFlippy
  class Config
    include Logger
    DEFAULT_API_URI = 'http://localhost'
    DEFAULT_OPEN_TIMEOUT = 3
    DEFAULT_READ_TIMEOUT = 10
    DEFAULT_POLLING_INTERVAL = 300

    attr_reader :api_uri
    attr_reader :open_timeout
    attr_reader :read_timeout
    attr_reader :polling_interval

    def initialize(opts = {})
      @api_uri = (opts[:api_uri] || DEFAULT_API_URI).chomp('/')
      @open_timeout = (opts[:open_timeout] || DEFAULT_OPEN_TIMEOUT)
      @read_timeout = (opts[:read_timeout] || DEFAULT_READ_TIMEOUT)
      @polling_interval = (opts[:polling_interval] || DEFAULT_POLLING_INTERVAL)
      Logger.logger = opts[:logger] if opts[:logger]
    end

    def self.default
      Config.new
    end
  end
end
