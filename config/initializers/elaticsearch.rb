require 'typhoeus'
require 'typhoeus/adapters/faraday'
require 'elasticsearch/model'

transport_configuration = lambda do |f|
  f.response :logger
  f.adapter  :typhoeus
end

transport = Elasticsearch::Transport::Transport::HTTP::Faraday.new \
  hosts: Setting.elasticsearch.hosts, &transport_configuration

Elasticsearch::Model.client = Elasticsearch::Persistence.client = Elasticsearch::Client.new(transport: transport)

 # = Elasticsearch::Client.new(host: "http://localhost:9200", log: true)
