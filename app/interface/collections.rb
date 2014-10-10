module LepoMongo
  class Collections < Grape::API
    resource '/:db' do
      get do
        collection_names
      end
    end
  end
end
