# spec/client_spec.rb
require 'spec_helper'
require 'ruby_for_grafana_loki'

RSpec.describe RubyForGrafanaLoki::Client do
  let(:log_file_path) { 'development.log' }
  let(:allowed_logs_type) { %w(ERROR WARN FATAL INFO DEBUG) }
  let(:client) { described_class.new(log_file_path, allowed_logs_type) }

  describe '#initialize' do
    it 'sets default values' do
      expect(client.job_name).to eq 'job name'
      expect(client.host_name).to eq 'host name'
      expect(client.source_name).to eq 'source name'
      expect(client.interaction_interval).to eq 1
      expect(client.max_buffer_size).to eq 100
    end
  end

  describe '#send_all_logs' do
    it 'sends logs to the server' do
      allow(client).to receive(:send_log)
      allow(File).to receive(:open).with(log_file_path, 'r').and_yield(StringIO.new("ERROR Test log"))

      client.send_all_logs

      expect(client).to have_received(:send_log).with('ERROR Test log').once
    end
  end

  describe '#send_log' do
    it 'buffers and sends logs when needed' do
      allow(client).to receive(:post)
      allow(client).to receive(:can_send_log?).and_return(false, true)

      client.send_log('ERROR Test log')
      client.send_log('INFO Another log')

      expect(client).to have_received(:post).once
    end
  end

  describe '#can_send_log?' do
    it 'returns true initially and after the interaction interval' do
      expect(client.send(:can_send_log?)).to be true

      client.instance_variable_set(:@last_interaction_time, Time.now - 2)
      expect(client.send(:can_send_log?)).to be true

      client.instance_variable_set(:@last_interaction_time, Time.now)
      expect(client.send(:can_send_log?)).to be false
    end
  end

  describe '#match_logs_type?' do
    it 'returns true for matching log types' do
      expect(client.send(:match_logs_type?, 'ERROR Test log')).to be true
      expect(client.send(:match_logs_type?, 'TRACE Another log')).to be false
    end
  end
end
