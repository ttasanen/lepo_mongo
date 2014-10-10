module LepoMongo
  class Collections < Grape::API
    resource '/:db' do
      get do
        current_database.collection_names
      end
    end
  end
end
