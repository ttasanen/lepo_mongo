module LepoMongo
  class Documents < Grape::API

    helpers do
      def parse_object_id(object_id)
        unless BSON::ObjectId.legal?(object_id)
          error!("Illegal ObjectID #{params[:id]}", 400)
        end

        BSON::ObjectId(object_id)
      end

      def find_by_object_id(id, collection)
        id = parse_object_id(id) unless id.is_a?(BSON::ObjectId)

        item = @db.collection(params[:collection]).find_one(id)
        unless item
          error!("Could not find document with #{id.inspect} in #{params[:db]}.#{params[:collection]}", 404)
        end

        item
      end
    end


    # GET /db/collection
    # Gets documents in collection
    get '/:db/:collection' do
      @db.collection(params[:collection]).find.to_a
    end

    # GET /db/collection/id
    # Gets given document
    get '/:db/:collection/:id' do
      find_by_object_id(params[:id], params[:collection])
    end

    # POST /db/collection
    # Creates new document
    post '/:db/:collection' do
    end

    # PATCH /db/collection/id
    # Updates a document
    patch '/:db/:collection/:id' do
      item = find_by_object_id(params[:id], params[:collection])
      data = extract_data(params.dup)

      data.reject! {|k, v| ['id', '_id'].include?(k)}

      @db.collection(params[:collection]).update({'_id' => item['_id']}, {'$set' => data})

      find_by_object_id(item['_id'], params[:collection])
    end

    # PUT /db/collection/id
    # Create or Replace document
    put '/:db/:collection/:id' do
      id = parse_object_id(params[:id])
      data = extract_data(params.dup)
      data['_id'] = id

      @db.collection(params[:collection]).save(data)

      find_by_object_id(id, params[:collection])
    end

    # DELETE /db/collection/id
    delete '/:db/:collection/:id' do
      item = find_by_object_id(params[:id], params[:collection])
      @db.collection(params[:collection]).remove({'_id' => item['_id']})
    end

  end
end
