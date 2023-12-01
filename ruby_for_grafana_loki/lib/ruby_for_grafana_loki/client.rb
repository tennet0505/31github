module RubyForGrafanaLoki class Client
  include RailsLokiExporterDev::Request
    def send_log(log_message)
      curr_datetime = Time.now.to_i * 1_000_000_000
      payload = {
        "streams" => [
          {
            "stream" => {
            "foo" => "bar2",
            "source" => "Name-of-your-source",
            "job" => "name-of-your-job",
            "host" => host
             },
            "values" => [["#{curr_datetime}", log_message]],
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
      post uri, json_payload
    end
  end
end