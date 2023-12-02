require 'faraday'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.setup

module RubyForGrafanaLoki 
  def self.client(log_folder)
    RailsLokiExporterDev::Client.new(log_folder)
  end
end