# coding: utf-8

if ENV['COVERAGE'] || ENV['CI']
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
  SimpleCov.start do
    command_name 'ci'
  end
end

require 'goflippy'
RSpec.configure do |config|
  config.order = :rand
  config.run_all_when_everything_filtered = true
end
