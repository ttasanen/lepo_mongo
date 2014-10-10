module LepoMongo
  class Databases < Grape::API
    resource '/' do
      get do
        connection.database_names
      end
    end
  end
end
