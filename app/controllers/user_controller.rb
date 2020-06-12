class UserController < ApplicationController

    get "/login" do
        if User.is_logged_in?(session)
            redirect "/user/show"
        else
            erb :"/user/login"
        end
    end

    get "/signup" do
        if User.is_logged_in?(session)
            redirect "/user/show"
        else
            erb :"/user/signup"
        end
    end

    get "/user/:slug" do
        binding.pry
        @user = User.current_user(session[:user_id])
        @user_page = User.find_by_slug(params[:slug])
        @characters = @user_page.characters
        erb :"/user/show"
    end

    post "/login" do
        @user = User.find_by(name: params[:name])

        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/user/#{@user.slug}"
        else
            redirect "/login"
        end
    end

    post "/signup" do
        
        if params[:name] == ""
            redirect "/signup"
        elsif params[:email] == ""
            redirect "/signup"
        elsif params[:password] == ""
            redirect "/signup"
        else
            @user = User.create(params)
            session[:user_id] = @user.id
            redirect "/user/#{@user.slug}"
        end
    end
    
    
end