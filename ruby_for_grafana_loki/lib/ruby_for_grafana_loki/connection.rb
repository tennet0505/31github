module RubyForGrafanaLoki
    module Connection
        # BASE_URL =  'http://localhost:3000/en/'
        BASE_URL = 'https://logs-prod-006.grafana.net'
        # BASE_URL = 'https://reqres.in/'
        # BASE_URL = 'https://api.funtranslations.com/'

        def connection
            Faraday.new(options) do |faraday|
                faraday.adapter Faraday.default_adapter
                faraday.request :url_encoded
            end
        end

        private

        def options
            headers = {
                accept: 'application/json',
                'Content-Type' => 'application/x-www-form-urlencoded'
            }
            return {
                url: BASE_URL
            }
        end
    end
end
