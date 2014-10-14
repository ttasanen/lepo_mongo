module LepoMongo
  module Helpers

    def connection
      host = ENV['mongo_host'] || 'localhost'
      port = ENV['mongo_port'] || 27017

      @connn ||= Mongo::Connection.new(host, port)
    end

    def authenticate!
      @conf = use_database('lepo_mongo').collection('lepo_config').find
      puts @conf.inspect
      true
    end

    def current_api_key
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
      databases.reject{|x| ['lepo_mongo'].include?(x)}
    end

    def filtered_collections(database_name)
      collections(database_name).reject{|x| ['system.indexes'].include?(x)}
    end

    def use_database(database)
      connection.db(database)
    end

  end
end
