module LepoMongo
  class Documents < Grape::API

    # GET /db/collection
    # Gets documents in collection
    get '/:db/:collection' do
      require_database(params[:db])
      require_collection(params[:collection])
      find_in_collection
    end

    # GET /db/collection/id
    # Gets given document
    get '/:db/:collection/:id' do
      require_database(params[:db])
      require_collection(params[:collection])
      # TODO
    end

    # POST /db/collection
    # Creates new document
    post '/:db/:collection' do
      require_database(params[:db])
      require_collection(params[:collection])
      # TODO
    end

    # PATCH /db/collection/id
    # Updates a document
    patch '/:db/:collection/:id' do
      require_database(params[:db])
      require_collection(params[:collection])
      # TODO
    end

    # DELETE /db/collection/id
    delete '/:db/:collection/:id' do
      require_database(params[:db])
      require_collection(params[:collection])
      # TODO
    end

  end
end
