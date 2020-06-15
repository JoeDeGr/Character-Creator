require 'pry'

class UserController < ApplicationController

    get "/login" do

        if User.is_logged_in?(session)
            @user = User.find_by_id(session[:user_id])
            redirect "/users/#{@user.slug}"
        else
            erb :"/users/login"
        end
    end

    get "/signup" do
        if User.is_logged_in?(session)
            @user = User.find_by_id(session[:user_id]) 
            redirect "/user/#{@user.slug}"
        else
            erb :"/users/signup"
        end
    end

    get "/users/:slug" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @user_page = User.find_by_slug(params[:slug])
            @characters = @user_page.characters
            erb :"/users/show"
        else
            redirect "/login"
        end 
    end

    get "/users/:slug/edit" do
        if User.is_logged_in?(session)
            @user = User.find_by_id(session[:user_id])
            @user_page = User.find_by_slug(params[:slug])
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

    post "/login" do
        binding.pry
        @user = User.find_by(name: params[:name])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/users/#{@user.slug}"
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
            redirect "/users/#{@user.slug}"
        end
    end

    patch "/signup/:slug" do
        
        if params[:name] == ""
            redirect "/users/:slug/edit"
        elsif params[:email] == ""
            redirect "/users/:slug/edit"
        elsif params[:password] == ""
            redirect "/users/:slug/edit"
        else
            @user = User.update(params)
            session[:user_id] = @user.id
            redirect "/users/#{@user.slug}"
        end
    end  
end