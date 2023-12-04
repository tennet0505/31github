module RubyForGrafanaLoki 
  module Request
    include RubyForGrafanaLoki:: Connection

    def post(url, payload)
      respond_with(
        connection.post url, payload
      )
    end

    private
    def respond_with(response)
      if response.success?
        puts 'Log sent successfully to Loki.'
        puts "Response code: #{response.status}, Response body: #{response.body}"
        body = response.body.empty? ? response.body : JSON.parse(response.body)
        puts body
      else
        puts "Failed to send log to Loki. Response code: #{response.status}, Response body: #{response.body}"
      end
    end
    def get(path)
      respond_with(
        connection.get(path)
      )
    end
  end
end