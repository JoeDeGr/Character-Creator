require 'pry'

class UserController < ApplicationController

    get "/login" do
        if User.is_logged_in?(session)
            @user = User.find_by_id(session[:user_id])
            redirect "/users/#{@user.id}"
        else
            @fail_message = session[:fail_message]
            session[:fail_message] = nil
            erb :"/users/login"
        end
    end

    get "/signup" do
        if User.is_logged_in?(session)
            @user = User.find_by_id(session[:user_id]) 
            redirect "/users/#{@user.id}"
        else
            @fail_message = session[:fail_message]
            session[:fail_message] = nil
            erb :"/users/signup"
        end
    end

    get "/users/:id" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @user_page = User.find_by_id(params[:id])
            @characters = @user_page.characters
            @success_message = session[:success_message]
            session[:success_message] = nil
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
                @fail_message = session[:fail_message]
                session[:fail_message] = nil
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

    post "/login" do
        @user = User.find_by(name: params[:name])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            session[:success_message] = "You Logged In!"
            redirect "/users/#{@user.id}"
        else
            session[:fail_message] = "Password or Username Incorrect! Please Try Again."
            redirect "/login"
        end

    end

    post "/users" do
        
        if params[:name] == ""
            session[:fail_message] = "Username was left blank. You must have a Username."
            redirect "/signup"
        elsif params[:email] == ""
            session[:fail_message] = "E-mail was left blank. You must have a E-mail."
            redirect "/signup"
        elsif params[:password] == ""
            session[:fail_message] = "Password was left blank. You must have a Password."
            redirect "/signup"
        elsif (params[:email] =~ /\A[a-z0-9\+\-_\.]+@[a-z\d\-.]+\.[a-z]+\z/i) != 0
            session[:fail_message] = "We apologize for the inconvienance, but you must have a conforming E-mail."
            redirect "/signup"
        elsif (User.exists?(name: params[:name]))
            session[:fail_message] = "You must have a unique Username."
            redirect "/signup"
        else
            @user = User.create(params)
            session[:user_id] = @user.id
            session[:success_message] = "Account Sucessfully Created!"
            redirect "/users/#{@user.id}"
        end
    end

    patch "/users/:id" do

        if User.is_logged_in?(session)

            @user = User.current_user(session)
            if params[:user][:name] == ""
                session[:fail_message] = "You Must Have A Name."
                redirect "/users/:id/edit"
            elsif params[:user][:email] == ""
                session[:fail_message] = "You Must Have An Email."
                redirect "/users/:id/edit"
            elsif params[:user][:password] == ""
                session[:fail_message] = "You Must Have A Password."
                redirect "/users/:id/edit"
            else
                @user.update(params[:user])
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