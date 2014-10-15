module LepoMongo
  module Helpers

    def connection
      @conn ||= get_connection
    end

    def get_connection
      host = ENV['LEPO_MONGO_HOST'] || 'localhost'
      port = ENV['LEPO_MONGO_PORT'] || Mongo::MongoClient::DEFAULT_PORT

      Mongo::Connection.new(host, port)
    end

    def config
      @conf ||= get_config
    end

    def get_config
      config_id = ENV['LEPO_MONGO_CONF']

      return default_config if config_id.nil?

      if  BSON::ObjectId.legal?(config_id)
        config_id = BSON::ObjectId(config_id)
      else
        begin
          config_id = JSON.parse(config_id)
        rescue JSON::ParserError
          puts "ERROR: Could not parse LEPO_MONGO_CONF. It is not valid JSON: #{config_id}"
          error!('Unexpected error occured', 500)
        end
      end

      config = use_database('lepo_mongo').collection('lepo_config').find_one(config_id)

      unless config
        puts "ERROR: Could not find configuration document defined in LEPO_MONGO_CONF: #{config_id}"
        error!('Unexpected error occured', 500)
      end

      config
    end

    def default_config
      {} # TODO
    end

    def authenticate!
      #puts params.inspect
      #puts @env.inspect
      puts config.inspect
      puts @env.keys.inspect
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
