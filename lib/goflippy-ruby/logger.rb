require 'logger'

module GoFlippy
  module Logger
    MESSAGE_PREFIX = '[GoFippy]'

    def self.logger
      @logger ||= defined?(Rails) && Rails.respond_to?(:logger) ?
                      Rails.logger :
                      ::Logger.new($stdout, level: ::Logger::DEBUG)
    end

    def self.logger=(logger)
      @logger = logger
    end

    def self.debug(message)
      self.logger.debug("#{MESSAGE_PREFIX} #{message}")
    end

    def self.info(message)
      self.logger.info("#{MESSAGE_PREFIX} #{message}")
    end

    def self.warn(message)
      self.logger.warn("#{MESSAGE_PREFIX} #{message}")
    end

    def self.error(message)
      self.logger.error("#{MESSAGE_PREFIX} #{message}")
    end

    def self.fatal(message)
      self.logger.fatal("#{MESSAGE_PREFIX} #{message}")
    end

    def self.unknown(message)
      self.logger.unknown("#{MESSAGE_PREFIX} #{message}")
    end
  end
end