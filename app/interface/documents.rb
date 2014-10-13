module LepoMongo
  class Documents < Grape::API

    # GET /db/collection
    # Gets documents in collection
    get '/:db/:collection' do
      use_database(params[:db]).collection(params[:collection]).find.to_a
    end

    # GET /db/collection/id
    # Gets given document
    get '/:db/:collection/:id' do
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
