require 'base64'

module RubyForGrafanaLoki
  module Connection
    BASE_URL = 'https://logs-prod-006.grafana.net' # Replace with your actual GEM instance URL
    USER_NAME = '747344'
    PASSWORD = 'glc_eyJvIjoiOTk0MjI2IiwibiI6InRva2VubG9raS10b2tlbm5hbWUiLCJrIjoiQWF0MTZoOTk5YndvQzFIUzV0MEExbUEyIiwibSI6eyJyIjoidXMifX0='

    def connection
      Faraday.new(options) do |faraday|
        faraday.adapter Faraday.default_adapter

        faraday.request :json # Add this line to log request details
        faraday.response :logger # Add this line to log response details to console
        faraday.response :json, content_type: /\bjson$/ # Assume JSON response

        # faraday.headers['Authorization'] = "Basic #{base64_encoded_credentials}"

        faraday.request :url_encoded
      end
    end

    def post(path, body)
      response = connection.post(path) do |req|
        req.headers['Content-Type'] = 'application/json'
        req.body = JSON.generate(body)
      end

      if response.success?
        JSON.parse(response.body)
      else
        raise "Failed to make POST request. Response code: #{response.status}, Response body: #{response.body}"
      end
    end

    private

    def base64_encoded_credentials
      credentials = "#{USER_NAME}:#{PASSWORD}"
      Base64.strict_encode64(credentials)
    end

    def options
      headers = {
        accept: 'application/json',
        'Content-Type' => 'application/json',
        'Authorization' => "Basic #{base64_encoded_credentials}"
      }
      {
        url: BASE_URL,
        headers: headers
      }
    end
  end
end