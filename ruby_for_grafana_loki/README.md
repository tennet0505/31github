
# Usage in your gem or application
log_file_path = "log/#{Rails.env}.log"
client = RubyForGrafanaLoki.client(log_file_path)
client.send_log("This is a log message.")
