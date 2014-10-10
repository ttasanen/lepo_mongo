module LepoMongo
  module Helpers

    def config
      return @config if @config

      @defaults = {mongo_host: 'localhost', mongo_port: 27017, hide_databases: ['local', 'admin'], hide_collections: ['system.indexes']}

      if File.exists?('config/config.yml')
        @config = @defaults.merge(YAML.load(File.read('config/config.yml')))
      end
    end

    def connection
      @connection ||= Mongo::Connection.new
    end

    def authenticate!
      # TODO: authentication
      puts params.inspect
      true
    end


    def database_names
      connection.database_names.reject!{|x| config[:hide_databases].include?(x)}
    end

    def collection_names
      current_database.collection_names.reject!{|x| config[:hide_collections].include?(x)}
    end

    def use_database(db)
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
