module LepoMongo
  module Helpers

    def connection
      return @conn if @conn

      host = ENV['LEPO_MONGO_HOST'] || 'localhost'
      port = ENV['LEPO_MONGO_PORT'] || Mongo::MongoClient::DEFAULT_PORT

      @conn = Mongo::Connection.new(host, port)
    end

    def config
      return @conf if @conf

      id = {}
      id = Mongo::ObjectID(ENV['LEPO_MONGO_CONF']) if ENV['LEPO_MONGO_CONF']

      @conf = use_database('lepo_mongo').collection('lepo_config').find_one(id) || {}
    end

    def authenticate!
      puts params.inspect
      puts @env.inspect
      true
    end

    def create_database(database_name)
      use_database(database_name).collection_names
      database_names.include?(database_name)
    end

    def database_exists?(database_name)
      database_names.include?(database_name)
    end

    def collection_exists?(database_name, collection_name)
      database_exists?(database_name) && collections(database_name).include?(collection_name)
    end

    def databases
      connection.database_names || []
    end

    def collections(database_name)
      use_database(database_name).collection_names || []
    end

    def filtered_databases
      databases.reject{|x| ['lepo_mongo', 'admin', 'local'].include?(x)}
    end

    def filtered_collections(database_name)
      # TODO: 2.0.0 does this automatically
      collections(database_name).reject{|x| ['system.indexes'].include?(x)}
    end

    def use_database(database)
      connection.db(database)
    end

  end
end
