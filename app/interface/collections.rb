module LepoMongo
  class Collections < Grape::API

    # GET /db
    # List all collections in given database
    get '/:db' do
      unless database_exists?(params[:db])
        error!("Could not find database #{params[:db]}", 404)
      end

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

    # PATCH /db/collection
    # Updates collection (Rename)
    patch '/:db/:collection' do
      #db.rename_collection
    end

  end
end
