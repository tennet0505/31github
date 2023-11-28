module RubyForGrafanaLoki
    class Client
       # host = 'http://localhost:3000/en/'
       host = 'https://logs-prod-006.grafana.net'
       url = 'loki/api/v1/push'
       curr_datetime = Time.now.strftime('%Y-%m-%d %H:%M:%S')
       msg = 'Your message'
       payload = {
         'streams' => [
            {
               'labels' => "{source=\"Name-of-your-source\",job=\"name-of-your-job\", host=\"#{host}\"}",
               'entries' => [
               {
                 'ts' => curr_datetime,
                 'line' => "[WARN] #{msg}"
               }
             ]
           }
         ]
       }
       json_payload = JSON.generate(payload)
    include RailsLokiExporterDev::Request
        def initialize
        end

        def someClientRequest()
            RailsLokiExporterDev::Query.new(
              post url, {data: json_payload}
            )
        end



        def getQuery(path) #"query", "query_range", "labels" and etc
            get "loki/api/v1/#{path}"
        end

        def getExample(path) #"query", "query_range", "labels" and etc
            get "api/users?page=#{path}"
        end

        def getDataFrafanaCloude(path)
          get ""
        end

        # def getTranslate(endpoint, text)
        #   RailsLokiExporterDev::Query.new(
        #     post "translate/#{endpoint}.json", { text: text}
        #   )
        # end
    end
end