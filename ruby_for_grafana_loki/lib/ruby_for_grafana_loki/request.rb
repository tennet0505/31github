module RubyForGrafanaLoki 
    module Request
         include RailsLokiExporterDev:: Connection

         def post(url, params = {})
             respond_with(
               connection.post(url, params)
             )
         end

         private
         def respond_with(response)
             body = response.body.empty? ? response.body : JSON.parse(response.body)
             # body['data']
         end

         def get(path)
             respond_with(
                 connection.get(path)
             )
         end
     end
end