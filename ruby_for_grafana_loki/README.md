
# Usage in your gem or application
<pre>


custom_levels = %w(ERROR WARN)  # Use custom logs type: ERROR, WARN, FATAL, INFO, DEBUG 
log_file_path = "log/#{Rails.env}.log"
client = RubyForGrafanaLoki.client(log_file_path)
client.send_all_logs
client.send_log("This is a log message.")
</pre>