# require './config/environment'

class ApplicationController<Sinatra::Base
    configure do
        enable :sessions
        set :public_folder, 'public'
        set :views, 'app/views' 
        set :session_secret, 'password_security'
        set :layout => :layout
    end

    get '/' do
        erb :index
    end
end