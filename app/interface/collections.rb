module LepoMongo
  class Collections < Grape::API

    # GET /db
    # List all collections in given database
    get '/:db' do
      filtered_collections(params[:db])
    end

    # POST /db
    # Creates a new collection
    post '/:db' do
    end

    # DELETE /db/collection
    # Deletes given collection
    delete '/:db/:collection' do
    end

  end
end
