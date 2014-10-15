module LepoMongo
  class Documents < Grape::API

    # GET /db/collection
    # Gets documents in collection
    get '/:db/:collection' do
      @db.collection(params[:collection]).find.to_a
    end

    # GET /db/collection/id
    # Gets given document
    get '/:db/:collection/:id' do
      if BSON::ObjectId.legal?(params[:id])
        id = BSON::ObjectId(params[:id])
        item = @db.collection(params[:collection]).find_one(id)
      else
        error!("Illegal ObjectID #{params[:id]}", 400)
      end

      unless item
        error!("Could not find document with #{id.inspect} in #{params[:db]}.#{params[:collection]}", 404)
      end

      item
    end

    # POST /db/collection
    # Creates new document
    post '/:db/:collection' do
    end

    # PATCH /db/collection/id
    # Updates a document
    patch '/:db/:collection/:id' do
    end

    # DELETE /db/collection/id
    delete '/:db/:collection/:id' do
    end

  end
end
