require 'faraday'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.setup

module RubyForGrafanaLoki 
     def self.client
         RailsLokiExporterDev::Client.new
     end
end