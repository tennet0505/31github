
# Usage in your gem or application
<pre>
 
 - add gem "ruby_for_grafana_loki-0.0.5.gem"                      //to the Gemfile
 - bundle install
 
 in the project:
 - logs_type = %w(ERROR WARN FATAL)                               // Use custom logs type: ERROR, WARN, FATAL, INFO, DEBUG 
 - log_file_path = "log/#{Rails.env}.log"
 - client = RubyForGrafanaLoki.client(log_file_path, logs_type)
 - client.jobName = "job name"                                    // your job name
 - client.hostName = "host name"                                  // your host name
 - client.sourceName = "source name"                              // your source name
 - client.send_all_logs
 - client.send_log("This is a test log message.")

</pre>