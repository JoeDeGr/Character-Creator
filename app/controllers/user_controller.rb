require 'pry'

class UserController < ApplicationController

    get "/login" do
        if User.is_logged_in?(session)
            @user = User.find_by_id(session[:user_id])
            redirect "/user/#{@user.slug}"
        else
            erb :"/user/login"
        end
    end

    get "/signup" do
        if User.is_logged_in?(session)
            @user = User.find_by_id(session[:user_id]) 
            redirect "/user/#{@user.slug}"
        else
            erb :"/user/signup"
        end
    end

    get "/user/:slug" do
        if User.is_logged_in?(session)
            @user = User.find_by_id(session[:user_id]) 
            @user_page = User.find_by_slug(params[:slug])
            @characters = @user_page.characters
            erb :"/user/show"
        else
            erb :"/user/login"
        end 
    end

    get "/user/:slug/edit" do
        if User.is_logged_in?(session)
            @user = User.find_by_id(session[:user_id])
            @user_page = User.find_by_slug(params[:slug])
            if @user.id == @user_page.id
                @characters = @user_page.characters
                erb :"/user/edit"
            end
        else
            session.clear
            erb :"/user/login"
        end 
    end

    get "/logout" do
        session.clear
        redirect "/login"
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

    patch "/signup/:slug" do
        
        if params[:name] == ""
            redirect "/user/:slug/edit"
        elsif params[:email] == ""
            redirect "/user/:slug/edit"
        elsif params[:password] == ""
            redirect "/user/:slug/edit"
        else
            @user = User.update(params)
            session[:user_id] = @user.id
            redirect "/user/#{@user.slug}"
        end
    end  
end