module LepoMongo
  class Documents < Grape::API
    resource '/:db/:collection' do
      get do
        current_collection.find().to_a
      end
    end
  end
end
