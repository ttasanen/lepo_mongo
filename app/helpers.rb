module LepoMongo
  module Helpers
    def connection
      @connection ||= Mongo::Connection.new
    end

    def use_database(db)
      # TODO: Filter system dbs
      # TODO: 404 if not exists, Strict option?
      @dbs ||= {}
      return @dbs[db] if @dbs[db]

      @dbs[db] = connection.db(db)
    end

    def current_database
      @db = use_database(params[:db])
      # TODO: Filter system dbs
      # TODO: 404 if not exists, Strict option?
      unless @db
        error!("Database #{params[:db]} does not exist")
      end
      @db
    end

    def current_collection
      # TODO: Check if exist
      # TODO: 404 if not exists, Strict option?
      current_database.collection(params[:collection])
    end
  end
end
