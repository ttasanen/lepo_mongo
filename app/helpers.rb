module LepoMongo
  module Helpers

    def config
      return @config if @config

      @defaults = {mongo_host: 'localhost', mongo_port: 27017, hide_databases: ['local', 'admin', 'lepo_mongo'], hide_collections: ['system.indexes']}

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


    # TODO: is this actually needed? Grape supports params requirements..
    def require_params!(required_params)
      required_params = [required_params] unless required_params.is_a?(Array)
      required_params.map!{|x| x.to_s}

      missing = required_params - ((params.keys - @env['rack.routing_args'].keys) & required_params)

      unless missing.empty?
        error!(["Missgin required parameters: ", missing], 400);
      end
    end

    def find_in_collection(collection = current_collection, query = parse_query)
      collection.find().to_a
    end

    def parse_query

    end

    def create_database(database_name)
      status = use_database(database_name).collection_names

      !!status
    end

    def database_exists?(database_name, filtered = true)
      database_names(filtered).include?(database_name)
    end

    def require_collection(collection_name)
      unless collection_names.include?(collection_name)
        error!("Could not find collection #{collection_name}", 404)
      end
    end

    def require_database(database_name)
      unless database_exists?(database_name)
        error!("Could not find database #{database_name}", 404)
      end
    end

    def database_names(filtered = true)
      dbs = connection.database_names
      if filtered
        dbs.reject!{|x| config[:hide_databases].include?(x)}
      else
        dbs
      end
    end

    def collection_names(db = current_database)
      db.collection_names.reject!{|x| config[:hide_collections].include?(x)} || []
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
