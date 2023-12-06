
# Usage in your gem or application
<pre>


logs_type = %w(ERROR WARN)  # Use custom logs type: ERROR, WARN, FATAL, INFO, DEBUG 
log_file_path = "log/#{Rails.env}.log"
client = RubyForGrafanaLoki.client(log_file_path, logs_type)
client.send_all_logs
client.send_log("This is a log message.")  # not required
</pre>