module LepoMongo
  class App
    def initialize
    end

    def self.instance
      @instance ||= Rack::Builder.new do
        use Rack::Cors do
          allow do
            origins '*'
            resource '*', headers: :any, methods: :get
          end
        end

        run LepoMongo::App.new
      end.to_app

    end

    def call(env)
      LepoMongo::Interface.call(env)
    end
  end
end
