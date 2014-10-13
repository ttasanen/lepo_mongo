require 'interface/collections'

module LepoMongo
  class Databases < Grape::API

    # GET /
    # List database names
    get '/' do
      database_names
    end

    # POST /
    # Create a new database if it does not exist
    post '/' do
      require_params!(:db)
      error!("Database already exists", 406) if database_exists?(params[:db], false)

      if create_database(params[:db])
        status 201
        {message: 'Database Created'}
      else
        error!("Database could not be created", 500)
      end
    end


    # DELETE /db
    # Deletes given database
    delete '/:db' do
      # TODO
    end

  end
end
