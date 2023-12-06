require 'faraday'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.setup

module RubyForGrafanaLoki
  def self.client(log_file_path, logs_type)
    RubyForGrafanaLoki::Client.new(log_file_path, logs_type)
  end
end