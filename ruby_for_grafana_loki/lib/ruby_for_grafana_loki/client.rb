module RubyForGrafanaLoki
  class Client
    include RubyForGrafanaLoki::Request

    def initialize(logger)
      @logger = logger
    end

    def send_log(log_message)
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

      # Use logger for sending logs to both default logger and Loki
      @logger.info "Sending log to Loki: #{json_payload}"

      # Send logs to Loki using the post method
      post(uri, json_payload)
    end
  end
end


# # In your application code
#
# # Example with Rails logger
# rails_logger = Logger.new(STDOUT)
# client = RailsLokiExporterDev.client(rails_logger)
#
# # Send a log entry to Loki
# client.send_log("This is a log message.")