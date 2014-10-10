require 'helpers'
require 'interface/databases'
require 'interface/collections'
require 'interface/documents'

module LepoMongo
  class Interface < Grape::API

    before do
      authenticate!
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
