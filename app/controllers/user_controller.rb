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

    post "/signup" do
        
        if params[:name] == ""
            redirect "/signup"
        elsif params[:email] == ""
            redirect "/signup"
        elsif params[:password] == ""
            redirect "/signup"
        elsif !(params[:email] == /\A[a-z0-9\+\-_\.]+@[a-z\d\-.]+\.[a-z]+\z/i)
            binding.pry
            redirect "/signup/email"
        elseif (User.include?(name: params[:name]))
            redirect "/signup/username"
        else
            binding.pry
            @user = User.create(params)
            session[:user_id] = @user.id
            binding.pry
            redirect "/users/#{@user.id}"
        end
    end

    patch "/signup/:id" do
        
        if params[:name] == ""
            redirect "/users/:id/edit"
        elsif params[:email] == ""
            redirect "/users/:id/edit"
        elsif params[:password] == ""
            redirect "/users/:id/edit"
        else
            @user = User.update(params)
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
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