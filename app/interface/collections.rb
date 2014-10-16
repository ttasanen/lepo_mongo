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
      unless database_exists?(params[:db])
        error!("Could not find database #{params[:db]}", 404)
      end

      if collection_exists?(params[:db], params[:collection])
        error!("Collection #{params[:collection]} already exists in #{params[:db]}", 406)
      end

      @db.create_collection(params[:collection])

      response(201, {created: params[:collection], ok: 1})
    end

    # DELETE /db/collection
    # Deletes given collection
    delete '/:db/:collection' do
      unless database_exists?(params[:db])
        error!("Could not find database #{params[:db]}", 404)
      end

      unless collection_exists?(params[:db], params[:collection])
        error!("Collection #{params[:collection]} does not exist in #{params[:db]}", 406)
      end

      @db.drop_collection(params[:collection])

      response(200, {dropped: params[:collection], ok: 1})
    end

    # PATCH /db/collection
    # Updates collection (Rename)
    patch '/:db/:collection' do
      unless database_exists?(params[:db])
        error!("Could not find database #{params[:db]}", 404)
      end

      unless collection_exists?(params[:db], params[:collection])
        error!("Collection #{params[:collection]} does not exist in #{params[:db]}", 404)
      end

      @db.rename_collection(params[:collection], params[:new_collection_name])

      response(200, {renamed_from: params[:collection], renamed_to: params[:new_collection_name], ok: 1})
    end

  end
end
