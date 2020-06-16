class LocationController < ApplicationController
    get "/locations" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @locations = Location.all
            erb :"locations/index"
        else
            redirect "/login"
        end
    end

    get "/locations/new" do
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
    get "/locations/:id" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @location = Location.find_by_id(params[:id])
            erb :"locations/show"
        else
            redirect "/login"
        end
    end

    get "/locations:id/edit" do
        if User.is_logged_in?(session)
            @user = User.current_user(session)
            @location = Location.find_by_id(params:[id])
            erb :"locations/edit"
        else
            redirect "/login"
        end
    end
end