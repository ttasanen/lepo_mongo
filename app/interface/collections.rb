module LepoMongo
  class Collections < Grape::API

    # GET /db
    # List all collections in given database
    get '/:db' do
      require_database(params[:db])
      collection_names
    end

    # POST /db
    # Creates a new collection
    post '/:db' do
      require_database(params[:db])
      # TODO
    end

    # DELETE /db/collection
    # Deletes given collection
    delete '/:db/:collection' do
      require_database(params[:db])
      require_collection(params[:collection])
      # TODO
    end

  end
end
