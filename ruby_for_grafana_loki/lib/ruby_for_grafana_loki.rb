require 'faraday'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.setup

module RubyForGrafanaLoki
  def self.client(logger)
    RubyForGrafanaLoki::Client.new(logger)
  end
end