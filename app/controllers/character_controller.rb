
require 'pry'

class CharacterController < ApplicationController
    get "/characters/new" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @characters = @user.characters
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
            @user_page = User.find_by_id(@character.user_id)
            if @user.id == @user_page.id
                erb :"/characters/edit"
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

        @user = User.current_user(session)
        @character = Character.create(params[:character])
        location = Location.create(params[:location])
        building = Building.create(params[:building])
        archatype = Archatype.create(params[:archatype])
        power = Power.create(params[:power])
        location.buildings << building
        archatype.powers <<  power
        @character.buildings << building
        @character.archatypes << archatype
        @character.locations << location
        @character.user_id = @user.id
        @character.save

        redirect "/characters/#{@character.id}"
    end
end