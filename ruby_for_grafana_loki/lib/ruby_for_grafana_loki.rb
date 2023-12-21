require 'faraday'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.setup

module RubyForGrafanaLoki
  def self.client(log_file_path, logs_type, options = {})
    intercept_logs = options.fetch(:intercept_logs, false)
    client = RubyForGrafanaLoki::Client.new(log_file_path, logs_type)
    logger = RubyForGrafanaLoki::InterceptingLogger.new(intercept_logs: intercept_logs)
    logger.client = client
    logger
  end
end