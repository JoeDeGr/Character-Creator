class LocationController < ApplicationController
    get "/locations" do
        @user = User.find_by_id(session[:users_id])
        @locations = Locations.all
        erb :"locations/index"
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
end