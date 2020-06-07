class ApplicationController<Sinatra::Base
    configure do
        enable :sessions
        set :public_folder, 'public'
        set :views, 'app/views' 
        set :session_secret, 'password_security'
    end

    get '/' do
        'Hello World'
    end
end