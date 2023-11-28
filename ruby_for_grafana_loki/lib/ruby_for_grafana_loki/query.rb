module RubyForGrafanaLoki
    class Query
        attr_reader :page_data, :data_all, :per_page_data
        def initialize(response)
            @page_data = response['page']
            @data_all = response['data']
            @per_page_data = response['per_page']
        end
    end
end