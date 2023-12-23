module RubyForGrafanaLoki
  module Connection
    BASE_URL = 'https://logs-prod-006.grafana.net' # Replace with your actual GEM instance URL

    def connection
      Faraday.new(options) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.request :url_encoded
        end
    end

    def post(path, body)
      puts "⭕️⭕️⭕️⭕️⭕️⭕️⭕️"
      response = connection.post(path) do |req|
        req.headers['Content-Type'] = 'application/json'
        req.headers['Authorization'] = "Basic #{base64_encoded_credentials}"
        req.body = JSON.generate(body)
      end

      if response.success?
        JSON.parse(response.body)
      else
        raise "Failed to make POST request. Response code: #{response.status}, Response body: #{response.body}"
      end
    end

    private
    def options
      { url: BASE_URL }
    end

    def base64_encoded_credentials
      # Replace 'your_username' and 'your_password' with your actual GEM username and access policy token
      username = '747344'
      password = 'glc_eyJvIjoiOTk0MjI2IiwibiI6InN0YWNrLTc5NDM0OC1obC1yZWFkLWxva2kiLCJrIjoiSnBJN3U4NUY4MmkyUk1TWWYwaDVNNTNtIiwibSI6eyJyIjoicHJvZC11cy1lYXN0LTAifX0='

      credentials = "#{username}:#{password}"
      Base64.strict_encode64(credentials)
    end
  end
end

# https://747344:glc_eyJvIjoiOTk0MjI2IiwibiI6InN0YWNrLTc5NDM0OC1obC1yZWFkLWxva2kiLCJrIjoiSnBJN3U4NUY4MmkyUk1TWWYwaDVNNTNtIiwibSI6eyJyIjoicHJvZC11cy1lYXN0LTAifX0=@logs-prod-006.grafana.net/loki/api/v1/push