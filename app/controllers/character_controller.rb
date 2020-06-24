
require 'pry'

class CharacterController < ApplicationController

    get "/characters" do

        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @characters = Character.all
            erb :"/characters/index"
        else
            redirect "/login"
        end 
    end

    get "/characters/new" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @locations = Location.all
            @archatypes = Archatype.all
            erb :"/characters/new"
        else
            redirect "/login"
        end 
    end

    get "/characters/:id/edit" do
        if User.is_logged_in?(session)
            @user = User.find_by_id(session[:user_id])
            @character = Character.find_by_id(params[:id])
            @locations = Location.all
            @archatypes = Archatype.all
            @powers = Power.all
            @user_page = User.find_by_id(@character.user_id)
            if @user.id == @user_page.id
                erb :"/characters/edit"
            else
                redirect "/users/#{@user.id}"
            end
        else
            session.clear
            erb :"/users/login"
        end 
    end
    
    get "/characters/:id" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @character = Character.find_by_id(params[:id])
            erb :"/characters/show"
        else
            redirect "/login"
        end 
    end

    post "/characters" do
        if User.is_logged_in?(session)
            @character = []
            @location = []
            @archatype = []
            @power = []
            @location = []
            @building = []
            user = User.current_user(session)
            if !(params[:character][:name] == "")
                @character = Character.create(params[:character])
            
                if !(params[:location][:name] == "")
                    @location = Location.create(params[:location])
                    @character.locations << @location
                 end
                if !(params[:building][:name] == "")
                    @building = Building.create(params[:building])
                    if !(@location == [])
                        @building.location = @location
                        @building.save
                    end
                    @character.buildings << @building
                end
                if !(params[:archatype][:name] == "")
                    @archatype = Archatype.create(params[:archatype])
                    @character.archatypes << @archatype
                end
                if !(params[:power][:name] == "")
                    @power = Power.create(params[:power])
                    if !(@archatype = [])
                        @archatype.powers << @power
                    end
                end
            @character.user_id = user.id
            @character.save
            redirect "/characters/#{@character.id}"
            else
                redirect "/characters/new"
            end
        else
            redirect "/login"
        end
    end

    patch "/characters/:id" do
 
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @character = Character.find_by_id(params[:id])
            @user_character = User.find_by_id(@character.user_id)
            
            if @user.id == @user_character.id
                @character.update(params[:character])
                redirect "/characters/#{@character.id}"
            else
                redirect "/users/#{@user.id}"
            end
        else
            redirect "/login"
        end
    end

    delete "/characters/:id" do
        Character.destroy(params[:id])
        redirect "/characters"
    end
end