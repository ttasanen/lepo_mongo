require 'helpers'
require 'interface/databases'
require 'interface/collections'
require 'interface/documents'

module LepoMongo
  class Interface < Grape::API

    def initialize
      @config = {mongo_host: 'localhost', mongo_port: 27017, hide_databases: ['local', 'admin'], hide_collections: ['system.indexes']}

      if File.exists?('config/config.yml')
        @config.merge!(YAML.load(File.read('config/config.yml')))
      end

      super
    end

    before do
      #error!("Permission denied for action: ", 406)
    end

    format :json
    content_type :json, 'application/json'
    content_type :xml, 'text/xml'

    helpers LepoMongo::Helpers

    mount LepoMongo::Databases
    mount LepoMongo::Collections
    mount LepoMongo::Documents
  end
end
