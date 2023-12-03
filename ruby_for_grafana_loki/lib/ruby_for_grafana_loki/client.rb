module RubyForGrafanaLoki
 class Client
    include RubyForGrafanaLoki::Request

    def initialize(logger)
      @logger = logger
    end

    def send_rails_logs_to_loki
      # Set up a log subscriber to capture Rails logs
      Rails.logger.extend(ActiveSupport::Logger.broadcast(self))

      # Optional: Set log level for Rails logger (debug, info, warn, error, fatal)
      Rails.logger.level = Logger::INFO

      # Log a message to demonstrate forwarding
      Rails.logger.info("This is a test log from Rails logger.")
    end

    # This method will be called when a log entry is received from Rails logger
    def <<(log_message)
      # Forward the log message to Loki using your existing logic
      send_log(log_message)
    end

    def send_log(log_message)
      # Your existing logic to send logs to Loki
      curr_datetime = Time.now.to_i * 1_000_000_000
      host = "somehost"
      msg = "On server #{host} detected error"

      payload = {
        "streams" => [
          {
            "stream" => {
              "source" => "Name-of-your-source",
              "job" => "name-of-your-job",
              "host" => host
            },
            "values" => [[curr_datetime.to_s, log_message]],
            "entries" => [
              {
                "ts" => curr_datetime,
                "line" => "[WARN] " + msg
              }
            ]
          }
        ]
      }

      json_payload = JSON.generate(payload)
      uri = '/loki/api/v1/push'

      # Use Rails logger for sending logs to both default Rails log and Loki
      @logger.info "Sending log to Loki: #{json_payload}"

      # Send logs to Loki using the post method
      post(uri, json_payload)
    end
end



## In your Rails application code

## Assuming you are in a context where `Rails.logger` is available
#rails_logger = Rails.logger

## Create an instance of the client
#client = RailsLokiExporterDev.client(rails_logger)

## Set up log forwarding from Rails logger to Loki
#client.send_rails_logs_to_loki