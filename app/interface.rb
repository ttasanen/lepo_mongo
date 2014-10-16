require 'helpers'
require 'interface/databases'
require 'interface/collections'
require 'interface/documents'

module LepoMongo
  class Interface < Grape::API

    before do
      authenticate!
      @db = use_database(params[:db]) if params[:db]
    end

    format :json
    content_type :json, 'application/json'
    content_type :xml, 'text/xml'

    formatter :json, ->(obj, env) { JSON.pretty_generate(obj) }

    helpers LepoMongo::Helpers

    mount LepoMongo::Documents
    mount LepoMongo::Collections
    mount LepoMongo::Databases

  end
end
