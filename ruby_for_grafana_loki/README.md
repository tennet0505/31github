

# Example with Rails logger
rails_logger = Logger.new(STDOUT)
client = RubyForGrafanaLoki.client(rails_logger)

# Send a log entry to Loki
client.send_log("This is a log message.")