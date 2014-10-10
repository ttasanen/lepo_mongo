module LepoMongo
  class Databases < Grape::API
    resource '/' do
      get do
        database_names
      end
    end
  end
end
