module LepoMongo
  class Databases < Grape::API

    # GET /
    # List database names
    get '/' do
      filtered_databases
    end

    # POST /
    # Create a new database if it does not exist
    post '/' do
      if database_exists?(params[:db])
        error!("Database already exists", 406)
      end

      if create_database(params[:db])
        response(201, {created: params[:db], ok: 1})
      else
        error!("Database could not be created", 500)
      end
    end

    # DELETE /db
    # Deletes given database
    delete '/:db' do
      unless database_exists?(params[:db])
        error!("Could not find Database #{params[:db]}", 404)
      end

      connection.drop_database(params[:db])
    end

  end
end
