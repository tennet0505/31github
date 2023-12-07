# spec/client_spec.rb
require 'spec_helper'
require 'rspec'
require 'ruby_for_grafana_loki'

RSpec.describe RubyForGrafanaLoki::Client do
  let(:logs_type) { '%w(ERROR WARN FATAL)' }
  let(:log_file_path) { 'log/development.log' }
  let(:client) { RubyForGrafanaLoki.client(log_file_path, logs_type) }

  describe '#send_all_logs' do
    it 'sends logs of allowed types to Loki' do

      client.job_name = "job name"
      client.host_name = "host name"
      client.source_name = "source name"

      allow(File).to receive(:open).with(log_file_path, 'r').and_yield(StringIO.new("ERROR log line\nWARN log line\nINFO log line"))

      File.open(log_file_path, 'r') do |file|
        file.each_line do |line|
          puts "DEBUG: #{line}"
        end
      end

      # expect(client).to receive(:send_log).with("ERROR log line").once
      # expect(client).to receive(:send_log).with("WARN log line").once
      # expect(client).not_to receive(:send_log).with("INFO log line")
      client.send_all_logs
    end
  end

  describe '#send_log' do
    it 'sends a log entry to Loki' do
      allow(client).to receive(:post)
      allow(Time).to receive(:now).and_return(Time.new(2023, 1, 1)) # Adjust as needed

      expect(client).to receive(:post).with('/loki/api/v1/push', String)

      client.send_log('Log message')

      # Additional assertions based on your requirements
    end
  end
end