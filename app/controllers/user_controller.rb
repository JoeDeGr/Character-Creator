require 'pry'

class UserController < ApplicationController

    get "/login" do
        if User.is_logged_in?(session)
            @user = User.find_by_id(session[:user_id])
            redirect "/users/#{@user.id}"
        else
            erb :"/users/login"
        end
    end

    get "/signup" do
        if User.is_logged_in?(session)
            @user = User.find_by_id(session[:user_id]) 
            redirect "/users/#{@user.id}"
        else
            erb :"/users/signup"
        end
    end

    get "/users/:id" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @user_page = User.find_by_id(params[:id])
            @characters = @user_page.characters
            erb :"/users/show"
        else
            redirect "/login"
        end 
    end

    get "/users/:id/edit" do
        if User.is_logged_in?(session)
            @user = User.find_by_id(session[:user_id])
            @user_page = User.find_by_id(params[:id])
            if @user.id == @user_page.id
                @characters = @user_page.characters
                erb :"/users/edit"
            else
                session.clear
                redirect "/users/login"
            end
        else
            session.clear
            redirect "/users/login"
        end 
    end

    get "/logout" do
        session.clear
        redirect "/"
    end

    get "/signup/email" do
        erb :"/users/signup_email_fail"
    end

    get "/signup/username" do
        @email = params[:email]
        erb :"/users/signup_username_fail"
    end

    post "/login" do
        @user = User.find_by(name: params[:name])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else
            redirect "/login"
        end
    end

    post "/users" do
        
        if params[:name] == ""
            redirect "/signup"
        elsif params[:email] == ""
            redirect "/signup"
        elsif params[:password] == ""
            redirect "/signup"
        elsif (params[:email] =~ /\A[a-z0-9\+\-_\.]+@[a-z\d\-.]+\.[a-z]+\z/i) != 0
            redirect "/signup/email"
        elsif (User.exists?(name: params[:name]))
            redirect "/signup/username"
        else
            @user = User.create(params)
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        end
    end

    patch "/users/:id" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            if params[:name] == ""
                
                redirect "/users/:id/edit"
            elsif params[:email] == ""
                redirect "/users/:id/edit"
            elsif params[:password] == ""
                redirect "/users/:id/edit"
            else
                binding.pry
                @user.name = params[:name]
                @user.email = params[:email]
                @user.password = params[:password]

                redirect "/users/#{@user.id}"
            end
        end
    end 
    
    delete "/users/:id" do
        @user = User.find_by_id(session[:user_id])
        @user_page = User.find_by_id(params[:id])
        if @user.id == @user_page.id
            session.clear
            User.destroy(params[:id])
            redirect "/"
        else
            session.clear
            redirect "/login"
        end
    end
end