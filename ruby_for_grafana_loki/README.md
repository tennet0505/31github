
## Prerequisites

What things you need to install the software and how to install them.

<pre>
You need to setup Grafana, Grafana Loki for your env: 
- you can follow this video: https://www.youtube.com/watch?v=0B-yQdSXFJE
- about Grafana https://grafana.com/docs/agent/latest/flow/setup/start-agent/
- brew install grafana (install Grafana) 
</pre>

# Usage gem in test env:
<pre>
To run gem for test(for Macbook):
after installing Grafana
- brew services start grafana (start Grafana)

  after start grafana open browser http://localhost:3000 (sighIn with login: admin, password: admin.)
  setup Grafana > Home > Connections > Data sources > Loki
  setup URL: http://localhost:3100

- brew services restart grafana-agent-flow                         // restart Grafana
- brew services stop grafana-agent-flow                            // stop Grafana

- Ctrl+C (stop Loki)                                               // stop Grafana Loki
</pre>

# Test gem with irb:
<pre>
Go to your project folder:
- gem uninstall build rails_loki_exporter_dev                       // if you install gem before
- gem build rails_loki_exporter_dev.gemspec
- gem install rails_loki_exporter_dev-0.0.1.gem
- irb (launch ruby's interactive console)

- require 'ruby_for_grafana_loki'
- logs_type = %w(ERROR WARN FATAL INFO)                             // use custom logs type: ERROR, WARN, FATAL, INFO, DEBUG
- log_file_path = "log/#{Rails.env}.log"                            // your path to *.log
- client = RailsLokiExporterDev.client(log_folder_name, logs_type)  // create client
- result = client.send_all_logs
</pre>

# Usage gem in your application:
<pre>
 - add gem "ruby_for_grafana_loki-0.0.6.gem"                        // to the Gemfile
 - bundle install
 
 in the project (add in config.ru file):
 - logs_type = %w(ERROR WARN FATAL)                                 // use custom logs type: ERROR, WARN, FATAL, INFO, DEBUG 
 - log_file_path = "log/#{Rails.env}.log"
 - client = RubyForGrafanaLoki.client(log_file_path, logs_type)
 - client.jobName = "your job name"                                 // your job name
 - client.hostName = "your host name"                               // your host name
 - client.sourceName = "your source name"                           // your source name
 - client.send_all_logs
 - client.send_log("This is a test log message.")                   // not required
</pre>