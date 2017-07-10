module GoFlippy
  class Config
    @@default_api_uri = 'http://localhost'
    @@default_open_timeout = 3
    @@default_read_timeout = 10
    @@default_polling_interval = 300

    attr_reader :api_uri, :open_timeout, :read_timeout, :polling_interval

    def initialize(opts = {})
      @api_uri = (opts[:api_uri] || @@default_api_uri).chomp('/')
      @open_timeout = (opts[:open_timeout] || @@default_open_timeout)
      @read_timeout = (opts[:read_timeout] || @@default_read_timeout)
      @polling_interval = (opts[:polling_interval] || @@default_polling_interval)
    end

    def self.default
      Config.new
    end
  end
end
